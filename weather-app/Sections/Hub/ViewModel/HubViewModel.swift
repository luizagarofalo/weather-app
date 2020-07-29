//
//  HubViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 21/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

protocol HubViewModelViewDelegate: AnyObject {
    func didStartLoading()
    func didFinishLoading(_ request: HubViewModel.Request)
    func didFinishLoadingWithError(_ error: CustomError)
}

class HubViewModel {
    
    enum Request {
        case current
        case forecast
    }
    
    // MARK: - Properties
    private var service = Service()
    
    var cityName: String?
    var latitude: String?
    var longitude: String?
    var location: Location?
    var hourlyForecast: HourlyForecast?
    var weather: CurrentWeather?
    
    weak var viewDelegate: HubViewModelViewDelegate?
    
    // MARK: - Public Methods
    func fetchCurrentWeather() {
        self.viewDelegate?.didStartLoading()
        guard let location = location else { return }
        
        let router: Router
        switch location {
        case .cityName:
            router = Router.current(nil, nil, cityName)
        case .coordinates:
            router = Router.current(latitude, longitude, nil)
        }
        
        service.request(router: router) { (result: Result<CurrentWeather, CustomError>) in
            switch result {
            case .success(let weather):
                self.weather = weather
                self.latitude = "\(weather.coord.lat)"
                self.longitude = "\(weather.coord.lon)"
                self.viewDelegate?.didFinishLoading(.current)
            case .failure(let error):
                self.viewDelegate?.didFinishLoadingWithError(error)
            }
        }
    }
    
    func fetchHourlyForecast() {
        let router = Router.forecast(latitude, longitude, nil)
        service.request(router: router) { (result: Result<HourlyForecast, CustomError>) in
            switch result {
            case .success(let hourlyForecast):
                self.hourlyForecast = hourlyForecast
                self.viewDelegate?.didFinishLoading(.forecast)
            case .failure(let error):
                self.viewDelegate?.didFinishLoadingWithError(error)
            }
        }
    }
    
    func updateLocation(city: String? = nil, lat: String? = nil, lon: String? = nil, location: Location? = nil) {
        self.cityName = city
        self.latitude = lat
        self.longitude = lon
        self.location = location
        self.fetchCurrentWeather()
    }
}
