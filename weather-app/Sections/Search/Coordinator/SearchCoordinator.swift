//
//  SearchCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator {
    
    // MARK: - Properties
    private var viewModel: SearchViewModel?
    private var viewController: SearchViewController?
    
    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Public Methods
    func start() -> SearchViewController {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
        return viewController
    }
    
    func stop() {
        viewModel = nil
        viewController = nil
    }
}
