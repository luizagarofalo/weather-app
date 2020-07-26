//
//  TabBarCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    private var hubCoordinator: HubCoordinator!
    private var searchCoordinator: SearchCoordinator!
    private var tabBar: TabBarController?
    private var window: UIWindow
    
    // MARK: - Initializers
    required init(window: UIWindow) {
        self.hubCoordinator = HubCoordinator()
        self.searchCoordinator = SearchCoordinator()
        self.tabBar = TabBarController()
        self.window = window
    }
    
    // MARK: - Public Methods
    func start() {
        tabBar?.viewControllers = [hubCoordinator.start(), searchCoordinator.start()]
        window.rootViewController = tabBar
        searchCoordinator.delegate = self
    }
    
    func stop() {
        hubCoordinator = nil
        tabBar = nil
    }
}

extension TabBarCoordinator: SearchCoordinatorDelegate {
    func didSelectCityName(_ cityName: String) {
        tabBar?.selectedIndex = 0
        hubCoordinator.viewModel?.cityName = cityName
        hubCoordinator.viewModel?.location = .cityName
        hubCoordinator.viewModel?.fetchCurrentWeather()
    }
    
    func didSelectCurrentLocation(latitude: String, longitude: String) {
        tabBar?.selectedIndex = 0
        hubCoordinator.viewModel?.latitude = latitude
        hubCoordinator.viewModel?.longitude = longitude
        hubCoordinator.viewModel?.location = .coordinates
        hubCoordinator.viewModel?.fetchCurrentWeather()
    }
}
