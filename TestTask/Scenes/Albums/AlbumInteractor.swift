//
//  AlbumInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//
import Foundation

protocol AlbumBusinessLogic: class {
    func fetchAlbums()
}

final class AlbumsInteractor: AlbumBusinessLogic {
    var presenter: AlbumPresentationLogic?
    var worker: AlbumsDataSourceWorker?
    
    func fetchAlbums() {
        
        print("DADA")
        let albumList = worker?.fetchAlbumsList(callback: { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let err):
                print(err)
            }
        })
        // Сюда albums засунуть
        presenter?.presentAlbums()
    }
}
