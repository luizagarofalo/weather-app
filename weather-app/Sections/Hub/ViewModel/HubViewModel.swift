//
//  HubViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 21/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import CoreLocation
import Foundation

class HubViewModel: NSObject {
    
    enum Location {
        case cityName
        case coordinates
    }
    
    // MARK: - Properties
    private var cityName: String?
    private var latitude: String?
    private var longitude: String?
    
    private var locationCoordinate: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    private var service = Service()
    
    // MARK: - Private Methods
    private func checkAuthorizationStatus(status: CLAuthorizationStatus? = nil) {
        switch status ?? CLLocationManager.authorizationStatus() {
        case .denied, .notDetermined, .restricted:
            locationManager.stopUpdatingLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func fetchCurrentWeather(_ location: Location) {
        let router: Router
        switch location {
        case .cityName:
            router = Router.current(nil, nil, cityName)
        case .coordinates:
            router = Router.current(latitude, longitude, nil)
        }
        
        service.request(router: router) { (result: Result<WeatherModel, Error>) in
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Public Methods
    func startLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}

extension HubViewModel: CLLocationManagerDelegate {
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
        
        fetchCurrentWeather(.coordinates)
    }
}
