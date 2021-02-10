//
//  SingleAlbumInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

protocol SingleAlbumBusinessLogic: class {
    func fetchSingleAlbum()
    func saveToLocalDB()
}

protocol SingleAlbumDataStore {
    var album: Album? { get set }
}

final class SingleAlbumInteractor: SingleAlbumBusinessLogic, SingleAlbumDataStore {
    var presenter: SingleAlbumPresentationLogic?
    var album: Album?
    var worker = SingleAlbumWorker()

    func fetchSingleAlbum() {
        guard let id = album?.id else { return }
        worker.fetchAlbumImages(for: id) { (result) in
            switch result {
            case .success(let response):
                self.presenter?.presentSingleAlbum(response)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func saveToLocalDB() {
        print("SAVE")
    }
}
