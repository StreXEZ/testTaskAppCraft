//
//  LocationModel.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import Foundation

enum LocationModel {
    enum LocationFetch {
        struct Request {
            
        }
        
        struct Response {
            let lat: Double
            let lon: Double
        }
        
        struct ViewModel {
            let location: String
        }
    }
}
