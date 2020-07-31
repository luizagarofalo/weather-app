//
//  SettingsCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 30/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didSelectUnit()
}

class SettingsCoordinator {
    
    // MARK: - Properties
    private var viewModel: SettingsViewModel?
    private var viewController: SettingsViewController?
    
    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    weak var delegate: SettingsCoordinatorDelegate?
    
    // MARK: - Public Methods
    func start() -> SettingsViewController {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        
        self.viewModel = viewModel
        self.viewController = viewController
        self.viewModel?.coordinatorDelegate = self
        
        navigation.pushViewController(viewController, animated: true)
        return viewController
    }
}

extension SettingsCoordinator: SettingsViewModelCoordinatorDelegate {
    func didSelectUnit() {
        delegate?.didSelectUnit()
    }
}
