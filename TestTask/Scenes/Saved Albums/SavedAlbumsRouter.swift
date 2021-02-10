//
//  SavedAlbumsRouter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 11.02.2021.
//

//import Foundation
//
//@objc protocol SavedAlbumsRoutingLogic {
//    func showAlbumPage(for flightNumber: Int)
//}
//
//protocol SavedAlbumsDataPassing {
//  var dataStore: SavedAlbumsDataStore? { get }
//}
//
//class SavedAlbumsRouter: NSObject, SavedAlbumsRoutingLogic, SavedAlbumsDataPassing {
//    var dataStore: SavedAlbumsDataStore?
//    weak var viewController: SavedAlbumsViewController?
//    
//    func showAlbumPage(for albumId: Int) {
//        guard let album = (dataStore?.albums?.first {$0.id == albumId}) else { return }
//        let vc = SingleAlbumViewController()
//        var destinationDS = vc.router!.dataStore!
//        passData(album: album, destination: &destinationDS)
//        viewController?.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    func passData(album: AlbumItem, destination: inout SingleAlbumDataStore) {
//        destination.album = album
//    }
//}
