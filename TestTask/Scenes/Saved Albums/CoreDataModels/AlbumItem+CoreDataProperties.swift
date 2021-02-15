//
//  AlbumItem+CoreDataProperties.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
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
    @NSManaged public var relationship: NSSet?
    
    public var imagesArray: [AlbumImage] {
        let set = relationship as? Set<AlbumImage> ?? []
        
        return set.sorted {
            $0.id < $1.id
        }
    }
    
    func toAlbum() -> Album {
        return Album(id: Int(self.id), userId: Int(self.userId), title: self.title ?? "")
    }
    
}

// MARK: Generated accessors for relationship
extension AlbumItem {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: AlbumImage)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: AlbumImage)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension AlbumItem : Identifiable {

}
