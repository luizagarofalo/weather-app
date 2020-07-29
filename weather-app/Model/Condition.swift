//
//  Condition.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

enum Condition: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy
    case fog
    case rain
    case snow
    case tornado
    case thunderstorm
    case unknown
    case windy
}


extension Weather {
    var condition: Condition {
        switch self.id {
        case 200...299:
            return .thunderstorm
        case 300...599:
            return .rain
        case 600...699:
            return .snow
        case 741:
            return .fog
        case 781:
            return .tornado
        case 700...799:
            return .windy
        case 800:
            return self.icon.last == "d" ? .clearDay : .clearNight
        case 801...899:
            return .cloudy
        default:
            return .unknown
        }
    }
}
