//
//  SavedAlbumsPresenter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

import Foundation

protocol SavedAlbumsPresentationLogic: class {
    func presentAlbums(_ data: SavedAlbums.FetchAlbums.Response)
}

final class SavedAlbumsPresenter: SavedAlbumsPresentationLogic {
    var viewController: SavedAlbumsDisplayLogic?
    func presentAlbums(_ data: SavedAlbums.FetchAlbums.Response) {

        let viewModel = SavedAlbums.FetchAlbums.ViewModel(albums: data.albums)
            viewController?.presentAlbumList(viewModel)

    }
}
