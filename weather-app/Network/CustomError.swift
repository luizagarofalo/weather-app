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
}
