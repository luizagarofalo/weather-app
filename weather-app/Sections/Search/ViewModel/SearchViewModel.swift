//
//  SearchViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import CoreLocation
import Foundation

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func didSelectCity(_ name: String)
    func didSelectCurrentLocation(latitude: String, longitude: String)
}

class SearchViewModel: NSObject {
    
    // MARK: - Properties
    private var cityName: String?
    private var latitude: String?
    private var longitude: String?
    private var locationCoordinate: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    // MARK: - Initializers
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    // MARK: - Private Methods
    private func checkAuthorizationStatus(status: CLAuthorizationStatus? = nil) {
        switch status ?? CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    // MARK: - Public Methods
    func searchCity(_ name: String) {
        coordinatorDelegate?.didSelectCity(name)
    }
    
    func useCurrentLocation() {
        checkAuthorizationStatus()
    }
}

extension SearchViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        locationCoordinate = lastLocation.coordinate
        locationManager.stopUpdatingLocation()
        
        guard let locationCoordinate = locationCoordinate else { return }
        latitude = String(format: "%f", locationCoordinate.latitude)
        longitude = String(format: "%f", locationCoordinate.longitude)
        
        guard let latitude = latitude, let longitude = longitude else { return }
        coordinatorDelegate?.didSelectCurrentLocation(latitude: latitude, longitude: longitude)
    }
}

