//
//  SavedAlbumsInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

import Foundation

protocol SavedAlbumsBusinessLogic: class {
    func fetchAlbums()
    func deleteAlbum(_ album: AlbumItem)
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
    
    func fetchAlbums() {
        guard let response = worker?.getListOfAlbums() else { return }
        albums = response.albums
        
        presenter?.presentAlbums(response)
    }
    
    func deleteAlbum(_ album: AlbumItem) {
        worker?.deleteAlbum(album)
        fetchAlbums()
    }
    
}
