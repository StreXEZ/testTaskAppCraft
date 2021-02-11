//
//  SavedAlbumsViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

import UIKit
import SnapKit

protocol SavedAlbumsDisplayLogic {
    func presentAlbumList(_ albums: SavedAlbums.FetchAlbums.ViewModel)
}

class SavedAlbumsViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    
    var interactor: SavedAlbumsBusinessLogic?
    var tableView: UITableView?
    
    var albums = [AlbumItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupUI()
        interactor?.fetchAlbums()
    }
    
    private func setup() {
        let interactor = SavedAlbumsInteractor()
        let presenter = SavedAlbumsPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
}

// MARK: - UI
extension SavedAlbumsViewController {
    private func setupUI() {
        view.addSubview(tableView!)
        tableView!.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
    }
}

// MARK: - TableView
extension SavedAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.refreshControl = self.refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAlbums), for: .valueChanged)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = albums[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let album = self.albums[indexPath.row]
            self.interactor?.deleteAlbum(album)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @objc
    func refreshAlbums() {
        interactor?.fetchAlbums()
        self.refreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
    
    @objc
    func startEditing() {
        tableView?.setEditing(!tableView!.isEditing, animated: true)
    }
}

extension SavedAlbumsViewController: SavedAlbumsDisplayLogic {
    func presentAlbumList(_ albums: SavedAlbums.FetchAlbums.ViewModel) {
        self.albums = albums.albums
        tableView?.reloadData()
    }
}
