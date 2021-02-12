//
//  SingleAlbumModel.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

enum SingleAlbumModel {
    enum FetchAlbum {
        struct Request {
            let isLocal: Bool
        }
        struct Response {
            let images: [SingleAlbumImage]
        }
        struct ViewModel {
            let images: [SingleAlbumImage]
        }
    }
}

struct SingleAlbumImage: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
