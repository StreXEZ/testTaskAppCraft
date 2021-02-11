//
//  ViewController.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import UIKit
import SnapKit

protocol AlbumsDisplayLogic {
    func presentAlbumList(_ albums: AlbumsModel.AlbumsFetch.ViewModel)
}

class AlbumsViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    private var tableView: UITableView?
    
    var interactor: AlbumsBusinessLogic?
    var router: AlbumsRoutingLogic?
    
    var albums = [Album]()
    
    var isLocalStorage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupUI()
        interactor?.fetchAlbums()
    }
    
    private func setup() {
        let interactor = AlbumsInteractor()
        let presenter = AlbumsPresenter()
        let router = AlbumsRouter()
        
        self.router = router
        self.interactor = interactor
        router.viewController = self
        interactor.presenter = presenter
        router.dataStore = interactor
        presenter.viewController = self
    }
}

// MARK: - UI
extension AlbumsViewController {
    private func setupUI() {
        view.addSubview(tableView!)
        tableView!.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
}

// MARK: - TableView
extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showAlbumPage(for: albums[indexPath.row].id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc
    func refreshAlbums() {
        interactor?.fetchAlbums()
        self.refreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
}

extension AlbumsViewController: AlbumsDisplayLogic {
    func presentAlbumList(_ albums: AlbumsModel.AlbumsFetch.ViewModel) {
        self.albums = albums.albums
        tableView?.reloadData()
    }
}
