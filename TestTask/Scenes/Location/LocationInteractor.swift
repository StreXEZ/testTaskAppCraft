//
//  LocationInteractor.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import Foundation
import CoreLocation
import MapKit
import AVFoundation

protocol LocationBusinessLogic {
    func toggleLocationService(_ request: LocationModel.LocationFetch.Request)
}

final class LocationIterator: NSObject, LocationBusinessLogic {
    // Private
    private var currentLocation: CLLocation?
    private var locManager = CLLocationManager()
    private var isParsingLocation = false
    private var player: AVAudioPlayer?
    
    // Public
    var presenter: LocationPresentationLogic?
    
    override init() {
        super.init()
        self.setupSound()
        locManager.delegate = self
        locManager.allowsBackgroundLocationUpdates = true
    }
    
    func toggleLocationService(_ request: LocationModel.LocationFetch.Request) {
        switch isParsingLocation {
        case false:
            startFetchingLocation()
            player?.play()
        case true:
            stopFetchingLocation()
            player?.stop()
        }
        isParsingLocation.toggle()
    }
    
    func startFetchingLocation() {
        locManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.startUpdatingLocation()
        }
    }
    
    func stopFetchingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locManager.stopUpdatingLocation()
        }
        presenter?.locationIsNotParsing()
    }
}
// MARK: - Location
extension LocationIterator: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        presenter?.presentLocation(LocationModel.LocationFetch.Response(lat: locations.last?.coordinate.latitude ?? 0.0, lon: locations.last?.coordinate.longitude ?? 0.0))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Sound
extension LocationIterator {
    func setupSound() {
        guard let url = Bundle.main.path(forResource: "sound", ofType: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:  url))
            player?.numberOfLoops = -1
        } catch let error {
            print(error)
        }
    }
}
