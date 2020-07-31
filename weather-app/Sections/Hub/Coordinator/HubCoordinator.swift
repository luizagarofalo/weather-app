//
//  HubCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class HubCoordinator {
    
    // MARK: - Properties
    private var viewModel: HubViewModel?
    private var viewController: HubViewController?
    
    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Public Methods
    func start() -> HubViewController {
        let viewModel = HubViewModel()
        let viewController = HubViewController(viewModel: viewModel)
        
        self.viewModel = viewModel
        self.viewController = viewController
        
        navigation.pushViewController(viewController, animated: true)
        return viewController
    }
    
    func updateLocation(city: String? = nil, lat: String? = nil, lon: String? = nil, location: Location? = nil) {
        viewModel?.updateLocation(city: city, lat: lat, lon: lon, location: location)
    }
    
    func reload() {
        viewModel?.fetchCurrentWeather()
    }
}
