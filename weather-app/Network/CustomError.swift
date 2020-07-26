//
//  CustomError.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 25/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case api
    case network
    case parse
    case unknown
    
    var title: String {
        switch self {
        case .api:
            return "Something Went Wrong"
        case .network:
            return "No Internet Connection"
        case .parse:
            return "City Not Found"
        case .unknown:
            return "Uh Oh"
        }
    }
    
    var description: String {
        switch self {
        case .api:
            return "We couldn't connect to the Open Weather API. Please try again later."
        case .network:
            return "We couldn't connect to internet. \nPlease check your network settings."
        case .parse:
            return "We couldn't locate the weather for the city name you've entered. Please check for any typos."
        case .unknown:
            return "Something weird happened. Please try again later."
        }
    }
    
    var shouldShowButton: Bool {
        switch self {
        case .api, .network, .unknown:
            return true
        case .parse:
            return false
        }
    }
}
