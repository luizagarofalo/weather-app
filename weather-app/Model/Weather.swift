//
//  Weather.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 28/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
