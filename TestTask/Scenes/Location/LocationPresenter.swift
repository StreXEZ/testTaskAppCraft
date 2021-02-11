//
//  LocationPresenter.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import Foundation

protocol LocationPresentationLogic {
    func presentLocation(_ response: LocationModel.LocationFetch.Response)
    func locationIsNotParsing()
}

final class LocationPresenter: LocationPresentationLogic {
    var viewController: LocationDisplayLogic?
    func presentLocation(_ response: LocationModel.LocationFetch.Response) {
        viewController?.showUserLocaiton(LocationModel.LocationFetch.ViewModel(location: "Lat: \(String(format: "%.4f", response.lat)) Lon: \(String(format: "%.4f", response.lon))"))
    }
    
    func locationIsNotParsing() {
        viewController?.userLocationIsNotShowing()
    }
}
