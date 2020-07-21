//
//  Router.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

enum Router {
    case current
    case forecast
    
    var scheme: String {
        switch self {
        case .current, .forecast:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .current:
            return "api.openweathermap.org"
        case .forecast:
            return "pro.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast/hourly"
        }
    }
    
    var parameters: [URLQueryItem] {
        let accessToken = "59191370e76ba00938f77ea19fff34d5"
        
        switch self {
        case .current, .forecast:
            return [URLQueryItem(name: "units", value: "metric"),
                    URLQueryItem(name: "q", value: "London"),
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

