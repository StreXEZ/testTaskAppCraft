//
//  SingleAlbumRouter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

protocol SingleAlbumRoutingLogic {
    func showImageDetails(_ album: SingleAlbumImage)
}

protocol SingleAlbumPageDataPassing {
  var dataStore: SingleAlbumDataStore? { get }
}

class SingleAlbumRouter: NSObject, SingleAlbumPageDataPassing, SingleAlbumRoutingLogic {
    weak var viewController: SingleAlbumViewController?
    var dataStore: SingleAlbumDataStore?
    
    func showImageDetails(_ album: SingleAlbumImage) {
    }
}
