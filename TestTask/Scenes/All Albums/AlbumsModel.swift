//
//  AlbumsModel.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

enum AlbumsModel {
    enum AlbumsFetch {
        struct Request {}
        
        struct Response {
            let albums: [Album]
        }
        
        struct ViewModel {
            let albums: [Album]
        }
    }
}

struct Album: Decodable {
    let id: Int
    let userId: Int
    let title: String
    
    func copy(id: Int, userId: Int, title: String) -> Album {
        return Album(id: id, userId: userId, title: title)
    }
}
