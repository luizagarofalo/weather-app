//
//  HourlyForecast.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 28/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

struct HourlyForecast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let hourly: [Hourly]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case hourly
    }
}

extension HourlyForecast {
    struct Hourly: Codable {
        let dt: Int
        let temp: Double
        let pressure, humidity: Int
        let clouds, visibility: Int
        let weather: [Weather]
        let pop: Double
    }
}
