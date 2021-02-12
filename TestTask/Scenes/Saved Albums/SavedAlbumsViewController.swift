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
    // Private
    private let refreshControl = UIRefreshControl()
    private var tableView: UITableView?
    
    // Public
    var interactor: SavedAlbumsBusinessLogic?
    var router: SavedAlbumsRoutingLogic?
    
    var albums = [AlbumItem]()
    
    lazy var placeholder: UILabel = {
        let label = UILabel()
        label.text = "You havent add any albums to your favourites"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupUI()
        interactor?.fetchAlbums(SavedAlbums.FetchAlbums.Request())
    }
    
    private func setup() {
        let interactor = SavedAlbumsInteractor()
        let presenter = SavedAlbumsPresenter()
        let router = SavedAlbumsRouter()
        
        self.interactor = interactor
        self.router = router
        router.viewController = self
        router.dataStore = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
}

// MARK: - UI
extension SavedAlbumsViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView!)
        tableView!.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        view.addSubview(placeholder)
        placeholder.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
    }
}

// MARK: - TableView
extension SavedAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableView.automaticDimension
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
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.showAlbumPage(for: Int(albums[indexPath.row].id))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let album = self.albums[indexPath.row]
            self.interactor?.deleteAlbum(SavedAlbums.DeleteAlbums.Request(album: album))
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @objc
    func refreshAlbums() {
        interactor?.fetchAlbums(SavedAlbums.FetchAlbums.Request())
        self.refreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
    
    @objc
    func startEditing() {
        tableView?.setEditing(!tableView!.isEditing, animated: true)
        if self.albums.count == 0 {
            tableView?.endEditing(true)
        }
    }
}

extension SavedAlbumsViewController: SavedAlbumsDisplayLogic {
    func presentAlbumList(_ albums: SavedAlbums.FetchAlbums.ViewModel) {
        self.albums = albums.albums
        placeholder.isHidden = !(self.albums.count == 0)
        tableView?.reloadData()
    }
}
