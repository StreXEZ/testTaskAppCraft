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
        guard let album = album else { return }
        localWorker.saveToLocalDB(album)
    }
}

class SingleAlbumLocalWorker {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveToLocalDB(_ album: Album) {
        do {
            let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
            let items = try context.fetch(request)
            if (items.first {$0.id == Int64(album.id)} == nil) {
                let localAlbum = AlbumItem(context: self.context)
                localAlbum.id = Int64(album.id)
                localAlbum.title = album.title
                localAlbum.userId = Int64(album.userId)
                try self.context.save()
                
            } else {
                print("Already in Storage")
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
