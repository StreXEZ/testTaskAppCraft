//
//  AlbumsRouter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

@objc protocol AlbumsRoutingLogic {
    func showAlbumPage(for flightNumber: Int)
}

protocol AlbumsDataPassing {
  var dataStore: AlbumsDataStore? { get }
}

class AlbumsRouter: NSObject, AlbumsRoutingLogic, AlbumsDataPassing {
    var dataStore: AlbumsDataStore?
    weak var viewController: AlbumsViewController?
    
    func showAlbumPage(for albumId: Int) {
        guard let album = (dataStore?.albums?.first {$0.id == albumId}) else { return }
        let vc = SingleAlbumViewController(isSaved: false)
        vc.title = album.title
        guard var destinationDS = vc.router?.dataStore else { return }
        passData(album: album, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passData(album: Album, destination: inout SingleAlbumDataStore) {
        destination.album = album
    }
}
