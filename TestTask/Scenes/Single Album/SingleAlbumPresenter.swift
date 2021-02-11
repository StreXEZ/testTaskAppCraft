//
//  SingleAlbumPresenter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

protocol SingleAlbumPresentationLogic: class {
    func presentSingleAlbum(_ response: SingleAlbumModel.FetchAlbum.Response)
    func presentDBInteraction(isSaved: Bool)
}

final class SingleAlbumPresentor: SingleAlbumPresentationLogic {
    weak var viewController: SingleAlbumDisplayLogic?
    
    deinit {
        print("Presenter deinited")
    }
    
    func presentSingleAlbum(_ response: SingleAlbumModel.FetchAlbum.Response) {
        let viewModel = SingleAlbumModel.FetchAlbum.ViewModel(images: response.images)
        viewController?.showSingleAlbum(viewModel)
    }
    
    func presentDBInteraction(isSaved: Bool) {
        viewController?.showDBInteractionButton(isSaved: isSaved)
    }
}
