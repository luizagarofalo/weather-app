//
//  HubViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 21/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import CoreLocation
import Foundation

protocol HubViewModelViewDelegate: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func didFinishLoadingWithError()
}

class HubViewModel: NSObject {
    
    // MARK: - Properties
    private var locationCoordinate: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    private var service = Service()
    
    var cityName: String?
    var latitude: String?
    var longitude: String?
    var weather: WeatherModel?
    
    weak var viewDelegate: HubViewModelViewDelegate?
    
    // MARK: - Public Methods
    func fetchCurrentWeather(_ location: Location) {
        self.viewDelegate?.didStartLoading()
        
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
                self.weather = weather
                self.viewDelegate?.didFinishLoading()
            case .failure:
                self.viewDelegate?.didFinishLoadingWithError()
            }
        }
    }
}
