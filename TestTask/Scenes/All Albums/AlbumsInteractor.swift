//
//  AlbumInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//
import Foundation

protocol AlbumsBusinessLogic: class {
    func fetchAlbums()
    var presenter: AlbumsPresentationLogic? { get set }
}

protocol AlbumsDataStore {
    var albums: [Album]? { get }
}

final class AlbumsInteractor: AlbumsBusinessLogic, AlbumsDataStore {
    var presenter: AlbumsPresentationLogic?
    var worker: AlbumsDataSourceWorker?
    var albums: [Album]?
    
    
    func fetchAlbums() {
        worker = AlbumsRemoteDataSource()
        worker?.fetchAlbumsList(callback: { (result) in
            switch result {
            case .success(let response):
                self.albums = response.albums
                self.presenter?.presentAlbums(response)
            case .failure(let err):
                print(err)
            }
        })
    }
}
