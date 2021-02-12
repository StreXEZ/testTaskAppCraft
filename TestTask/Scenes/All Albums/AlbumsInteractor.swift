//
//  AlbumInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//
import Foundation

protocol AlbumsBusinessLogic: class {
    func fetchAlbums(_ request: AlbumsModel.AlbumsFetch.Request)
    var presenter: AlbumsPresentationLogic? { get set }
}

protocol AlbumsDataStore {
    var albums: [Album]? { get }
}

final class AlbumsInteractor: AlbumsBusinessLogic, AlbumsDataStore {
    var presenter: AlbumsPresentationLogic?
    var worker: AlbumsDataSourceWorker = AlbumsRemoteDataSource()
    var albums: [Album]?
    
    
    func fetchAlbums(_ request: AlbumsModel.AlbumsFetch.Request) {
        worker.fetchAlbumsList(callback: { (result) in
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
