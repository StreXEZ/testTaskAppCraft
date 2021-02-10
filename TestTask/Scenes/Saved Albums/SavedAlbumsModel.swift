//
//  SavedAlbumsModel.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

import Foundation

enum SavedAlbums {
    enum FetchAlbums {
        struct Request {}
        struct Response {
            let albums: [AlbumItem]
        }
        struct ViewModel {
            let albums: [AlbumItem]
        }
    }
    
    enum DeleteAlbums {
        struct Request {
            let album: AlbumItem
        }
        struct Response {}
        struct ViewModel {}
    }
}
