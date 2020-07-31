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
    private var settingsCoordinator: SettingsCoordinator!
    private var tabBar: TabBarController?
    private var window: UIWindow
    
    // MARK: - Initializers
    required init(window: UIWindow) {
        self.hubCoordinator = HubCoordinator()
        self.searchCoordinator = SearchCoordinator()
        self.settingsCoordinator = SettingsCoordinator()
        self.tabBar = TabBarController()
        self.window = window
    }
    
    // MARK: - Public Methods
    func start() {
        tabBar?.viewControllers = [hubCoordinator.start(), searchCoordinator.start(), settingsCoordinator.start()]
        window.rootViewController = tabBar
        searchCoordinator.delegate = self
    }
}

extension TabBarCoordinator: SearchCoordinatorDelegate {
    func didSelectCityName(_ cityName: String) {
        tabBar?.selectedIndex = 0
        hubCoordinator.updateLocation(city: cityName, location: .cityName)
    }
    
    func didSelectCurrentLocation(latitude: String, longitude: String) {
        tabBar?.selectedIndex = 0
        hubCoordinator.updateLocation(lat: latitude, lon: longitude, location: .coordinates)
    }
}
