//
//  Unit.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 31/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

enum Unit: String {
    case celsius
    case fahrenheit
    case kelvin
    
    var coordinate: CGFloat {
        switch self {
        case .celsius: return 4
        case .fahrenheit: return 98
        case .kelvin: return 192
        }
    }
    
    var description: String {
        switch self {
        case .celsius: return "metric"
        case .fahrenheit: return "imperial"
        case .kelvin: return "standard"
        }
    }
    
    var rawValue: String {
        switch self {
        case .celsius: return "celsius"
        case .fahrenheit: return "fahrenheit"
        case .kelvin: return "kelvin"
        }
    }
}
