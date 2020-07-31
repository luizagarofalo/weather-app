//
//  SettingsViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 30/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    func didSelectUnit()
}

class SettingsViewModel {
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?
    
    // MARK: - Public Methods
    func getStoredUnit() -> Unit {
        guard let storedUnit = UserDefaults.standard.string(forKey: "unit"),
            let unit = Unit(rawValue: storedUnit) else {
                return .celsius
        }
        
        return unit
    }
    
    func selectUnit(_ unit: Unit) {
        defaults.set(unit.rawValue, forKey: "unit")
        coordinatorDelegate?.didSelectUnit()
    }
}
