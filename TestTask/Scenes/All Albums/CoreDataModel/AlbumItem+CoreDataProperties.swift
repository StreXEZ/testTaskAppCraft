//
//  AlbumItem+CoreDataProperties.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//
//

import Foundation
import CoreData


extension AlbumItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumItem> {
        return NSFetchRequest<AlbumItem>(entityName: "AlbumItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
    
    func toAlbum() -> Album {
        return Album(id: Int(self.id), userId: Int(self.userId), title: self.title ?? "")
    }
    
    var album: Album {
        get {
            return Album(id: Int(self.id), userId: Int(self.userId), title: self.title ?? "")
        }
        set {
            self.id = Int64(newValue.id)
            self.title = newValue.title
            self.userId = Int64(newValue.userId)
        }
    }

}

extension AlbumItem : Identifiable {

}
