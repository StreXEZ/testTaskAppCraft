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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        let request = AlbumsModel.AlbumsFetch.Request()
        interactor?.fetchAlbums(request)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "user \(album.userId)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return cell
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
        let request = AlbumsModel.AlbumsFetch.Request()
        interactor?.fetchAlbums(request)
        self.refreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
}

extension AlbumsViewController: AlbumsDisplayLogic {
    func presentAlbumList(_ albums: AlbumsModel.AlbumsFetch.ViewModel) {
        self.albums = albums.albums
        tableView?.reloadData()
    }
}
