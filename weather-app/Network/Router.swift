//
//  Router.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

enum Router {
    case current(_ lat: String?, _ lon: String?, _ city: String?)
    case forecast(_ lat: String?, _ lon: String?, _ city: String?)
    
    var scheme: String {
        switch self {
        case .current, .forecast:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .current, .forecast:
            return "api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/onecall"
        }
    }
    
    var parameters: [URLQueryItem] {
        let accessToken = "59191370e76ba00938f77ea19fff34d5"
        let storedUnit = UserDefaults.standard.string(forKey: "unit")
        let unit = Unit(rawValue: storedUnit ?? "celsius")
        
        switch self {
        case .current(let lat, let lon, let city), .forecast(let lat, let lon, let city):
            return [URLQueryItem(name: "units", value: unit?.description ?? "metric"),
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "lat", value: lat),
                    URLQueryItem(name: "lon", value: lon),
                    URLQueryItem(name: "exclude", value: "current,minutely,daily"),
                    URLQueryItem(name: "appid", value: accessToken)]
        }
    }
    
    var method: String {
        switch self {
        case .current, .forecast:
            return "GET"
        }
    }
}

