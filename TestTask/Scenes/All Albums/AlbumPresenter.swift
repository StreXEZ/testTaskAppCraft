//
//  AlbumPresenter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import Foundation

protocol AlbumsPresentationLogic: class {
    func presentAlbums(_ data: AlbumsModel.AlbumsFetch.Response)
}

final class AlbumsPresenter: AlbumsPresentationLogic {
    var viewController: AlbumsDisplayLogic?
    func presentAlbums(_ data: AlbumsModel.AlbumsFetch.Response) {

        let viewModel = AlbumsModel.AlbumsFetch.ViewModel(albums: data.albums)
            viewController?.presentAlbumList(viewModel)

    }
}
