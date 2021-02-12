//
//  SavedAlbumsInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

import Foundation

protocol SavedAlbumsBusinessLogic: class {
    func fetchAlbums(_ request: SavedAlbums.FetchAlbums.Request)
    func deleteAlbum(_ album: SavedAlbums.DeleteAlbums.Request)
    var presenter: SavedAlbumsPresentationLogic? { get set }
}

protocol SavedAlbumsDataStore {
    var albums: [AlbumItem]? { get }
}


final class SavedAlbumsInteractor: SavedAlbumsBusinessLogic, SavedAlbumsDataStore {
    var presenter: SavedAlbumsPresentationLogic?
    var albums: [AlbumItem]?
    var worker: SavedAlbumsWorker?
    
    init(worker: SavedAlbumsWorker? = SavedAlbumsWorker()) {
        self.worker = worker
    }
    
    func fetchAlbums(_ request: SavedAlbums.FetchAlbums.Request) {
        guard let response = worker?.getListOfAlbums() else { return }
        albums = response.albums
        
        presenter?.presentAlbums(response)
    }
    
    func deleteAlbum(_ album: SavedAlbums.DeleteAlbums.Request) {
        worker?.deleteAlbum(album.album)
        fetchAlbums(SavedAlbums.FetchAlbums.Request())
    }
    
}
