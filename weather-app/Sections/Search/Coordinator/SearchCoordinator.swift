//
//  SearchCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func didSelectCityName(_ cityName: String)
    func didSelectCurrentLocation(latitude: String, longitude: String)
}

class SearchCoordinator {
    
    // MARK: - Properties
    var viewModel: SearchViewModel?
    var viewController: SearchViewController?
    
    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    weak var delegate: SearchCoordinatorDelegate?
    
    // MARK: - Public Methods
    func start() -> SearchViewController {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: viewModel)
        
        self.viewModel = viewModel
        self.viewController = viewController
        self.viewModel?.coordinatorDelegate = self

        navigation.pushViewController(viewController, animated: true)
        return viewController
    }
}

extension SearchCoordinator: SearchViewModelCoordinatorDelegate {
    func didSelectCity(_ name: String) {
        delegate?.didSelectCityName(name)
    }
    
    func didSelectCurrentLocation(latitude: String, longitude: String) {
        delegate?.didSelectCurrentLocation(latitude: latitude, longitude: longitude)
    }
}
