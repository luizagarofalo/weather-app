//
//  CLLocationManagerMock.swift
//  weather-appTests
//
//  Created by Luiza Collado Garofalo on 07/08/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import CoreLocation

class CLLocationManagerMock: CLLocationManager {
    var status: CLAuthorizationStatus!
    private var desiredLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    var didStartUpdatingLocation = false
    
    init(desiredStatus: CLAuthorizationStatus) {
        status = desiredStatus
    }
    
    init(desiredLocation: CLLocation) {
        self.desiredLocation = desiredLocation
    }
    
    override func startUpdatingLocation() {
        didStartUpdatingLocation = true
        self.delegate?.locationManager?(self, didUpdateLocations: [desiredLocation])
    }
    
    override func requestWhenInUseAuthorization() {
        self.delegate?.locationManager?(self, didChangeAuthorization: status)
    }
}
