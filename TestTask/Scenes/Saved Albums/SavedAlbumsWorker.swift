//
//  SavedAlbumsWorker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//
import Foundation
import CoreData
import UIKit

class SavedAlbumsWorker {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getListOfAlbums() -> SavedAlbums.FetchAlbums.Response {
        let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
        var items = [AlbumItem]()
        do {
            items = try context.fetch(request)
        } catch {
            items = []
        }
        return SavedAlbums.FetchAlbums.Response(albums: items)
    }
    
    func deleteAlbum(_ album: AlbumItem) {
        self.context.delete(album)
        do {
            try self.context.save()
        } catch {
            fatalError("Failed to save")
        }
    }
}
