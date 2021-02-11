//
//  SingleAlbumInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation
import UIKit
import CoreData

protocol SingleAlbumBusinessLogic: class {
    func fetchSingleAlbum(_ isLocal: Bool)
    func saveToLocalDB(_ images: [SingleAlbumImage])
    func deleteFromLocalDB()
}

protocol SingleAlbumDataStore {
    var album: Album? { get set }
}

final class SingleAlbumInteractor: SingleAlbumBusinessLogic, SingleAlbumDataStore {
    var presenter: SingleAlbumPresentationLogic?
    var album: Album?
    var worker = SingleAlbumWorker()
    var localWorker = SingleAlbumLocalWorker()

    func fetchSingleAlbum(_ isLocal: Bool) {
        guard let id = album?.id else { return }
        if !isLocal {
            worker.fetchAlbumImages(for: id) { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.presenter?.presentSingleAlbum(response)
                    self?.presenter?.presentDBInteraction(isSaved: self!.localWorker.isAlbumIsSaved(self!.album!))
                case .failure(let err):
                    print(err)
                }
            }
        } else {
            self.presenter?.presentSingleAlbum(SingleAlbumModel.FetchAlbum.Response(images: localWorker.fetchFromLocalDB(id) ?? []))
            self.presenter?.presentDBInteraction(isSaved: true)
        }
    }
    
    func saveToLocalDB(_ images: [SingleAlbumImage]) {
        guard let album = album else { return }
        localWorker.saveToLocalDB(album, images: images)
        presenter?.presentDBInteraction(isSaved: true)
    }
    
    func deleteFromLocalDB() {
        guard let album = album else { return }
        localWorker.deleteFromDB(album)
        presenter?.presentDBInteraction(isSaved: false)
    }
}
