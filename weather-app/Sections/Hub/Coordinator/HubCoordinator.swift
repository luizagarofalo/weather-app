//
//  HubCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
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
        navigation.pushViewController(viewController, animated: true)
        return viewController
    }
    
    func stop() {
        viewModel = nil
        viewController = nil
    }
}
