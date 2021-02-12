//
//  SingleAlbumLocalWorker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 12.02.2021.
//

import Foundation
import UIKit
import CoreData

class SingleAlbumLocalWorker {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchFromLocalDB(_ albumId: Int) -> [SingleAlbumImage]? {
        let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
        var item: AlbumItem?
        do {
            item = try context.fetch(request).first { $0.id == albumId }
        } catch {
            print("Could Not Fetch local data")
        }
        return item?.imagesArray.map { $0.toSingleAlbumImage() }

    }
    
    func isAlbumIsSaved(_ album: Album) -> Bool {
        do {
        let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
        let items = try context.fetch(request)
        if (items.first {$0.id == Int64(album.id)} == nil) {
            return false
        } else {
            return true
        }
        } catch {
            return false
        }
    }
    
    func saveToLocalDB(_ album: Album, images: [SingleAlbumImage]) {
        do {
            if !isAlbumIsSaved(album) {
                let localAlbum = AlbumItem(context: self.context)
                localAlbum.id = Int64(album.id)
                localAlbum.title = album.title
                localAlbum.userId = Int64(album.userId)
                
                for image in images {
                    let img = AlbumImage(context: self.context)
                    img.albumId = Int64(image.albumId)
                    img.id = Int64(image.id)
                    img.thumbnailUrl = image.thumbnailUrl
                    img.url = image.url
                    localAlbum.addToRelationship(img)
                }
                try self.context.save()
            }
        } catch {
            print("Failed to fetch album from CoreData")
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
