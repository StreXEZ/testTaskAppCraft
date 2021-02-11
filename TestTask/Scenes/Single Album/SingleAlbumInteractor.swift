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
    func fetchSingleAlbum()
    func saveToLocalDB()
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

    func fetchSingleAlbum() {
        guard let id = album?.id else { return }
        worker.fetchAlbumImages(for: id) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.presentSingleAlbum(response)
                self?.presenter?.presentDBInteraction(isSaved: self!.localWorker.isAlbumIsSaved(self!.album!))
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func saveToLocalDB() {
        guard let album = album else { return }
        localWorker.saveToLocalDB(album)
        presenter?.presentDBInteraction(isSaved: true)
    }
    
    func deleteFromLocalDB() {
        guard let album = album else { return }
        localWorker.deleteFromDB(album)
        presenter?.presentDBInteraction(isSaved: false)
    }
}

class SingleAlbumLocalWorker {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func isAlbumIsSaved(_ album: Album) -> Bool {
        do {
        let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
        let items = try context.fetch(request)
        if (items.first {$0.id == Int64(album.id)} == nil) {
            return false
        } else {
            print("ALREADY SAVED")
            return true
        }
        } catch {
            return false
        }
    }
    
    func saveToLocalDB(_ album: Album) {
        do {
            if !isAlbumIsSaved(album) {
                let localAlbum = AlbumItem(context: self.context)
                localAlbum.id = Int64(album.id)
                localAlbum.title = album.title
                localAlbum.userId = Int64(album.userId)
                try self.context.save()
            }
        } catch {
            fatalError("Fail CoreData")
        }
    }
    
    func deleteFromDB(_ album: Album) {
        do {
            let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
            let items = try context.fetch(request)
            context.delete(items.first{ Int($0.id) == album.id}!)
            try context.save()
        } catch {
            print("Failed to dele item")
        }
    }
}
