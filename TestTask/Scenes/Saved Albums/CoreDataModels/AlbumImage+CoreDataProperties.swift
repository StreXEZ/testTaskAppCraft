//
//  AlbumImage+CoreDataProperties.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//
//

import Foundation
import CoreData


extension AlbumImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumImage> {
        return NSFetchRequest<AlbumImage>(entityName: "AlbumImage")
    }

    @NSManaged public var title: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var albumId: Int64
    @NSManaged public var relationship: AlbumItem?
    
    func toSingleAlbumImage() -> SingleAlbumImage {
        return SingleAlbumImage(albumId: Int(self.albumId), id: Int(self.id), title: self.title ?? "", url: self.url ?? "", thumbnailUrl: self.thumbnailUrl ?? "")
    }
}

extension AlbumImage : Identifiable {

}
