//
//  SingleAlbumPresenter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

protocol SingleAlbumPresentationLogic: class {
    func presentSingleAlbum(_ response: SingleAlbumModel.FetchAlbum.Response)
}

final class SingleAlbumPresentor: SingleAlbumPresentationLogic {
    var viewController: SingleAlbumDisplayLogic?
    
    func presentSingleAlbum(_ response: SingleAlbumModel.FetchAlbum.Response) {
        let viewModel = SingleAlbumModel.FetchAlbum.ViewModel(images: response.images)
        viewController?.showSingleAlbum(viewModel)
    }
}
