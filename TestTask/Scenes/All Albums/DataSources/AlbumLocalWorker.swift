//
//  AlbumLocalWorker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation
import CoreData
import UIKit

class AlbumsLocalWorker {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getListOfAlbums() -> AlbumsModel.AlbumsFetch.Response {
        let request = AlbumItem.fetchRequest() as NSFetchRequest<AlbumItem>
        var items = [Album]()
        do {
            items = (try context.fetch(request)).map{ $0.toAlbum() }
        } catch {
            items = []
        }
        return AlbumsModel.AlbumsFetch.Response(albums: items)
    }
}
