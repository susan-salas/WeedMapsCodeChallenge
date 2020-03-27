//
//  LocationManager.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/26/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation
import CoreLocation

class AppLocationManager : NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    var locationAllowed: Bool = {
        if CLLocationManager.locationServicesEnabled(){
            return true
        }
        return false
    }()
    
    var currentLatitude: Double = 0
    
    var currentLongitude: Double = 0
    
    override init() {
        super.init()
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            currentLongitude = location.coordinate.longitude
            currentLatitude = location.coordinate.latitude
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
