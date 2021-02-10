//
//  SingleAlbumRouter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

protocol SingleAlbumPageDataPassing {
  var dataStore: SingleAlbumDataStore? { get }
}

class SingleAlbumRouter: NSObject, SingleAlbumPageDataPassing {
    weak var viewController: SingleAlbumViewController?
    var dataStore: SingleAlbumDataStore?
}
