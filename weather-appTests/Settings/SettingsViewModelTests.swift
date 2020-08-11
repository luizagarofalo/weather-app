//
//  SettingsViewModelTests.swift
//  weather-appTests
//
//  Created by Luiza Collado Garofalo on 07/08/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import XCTest
@testable import weather_app

class SettingsViewModelTests: XCTestCase {

    // MARK: - Properties
    var delegateWasCalled = false
    var viewModel: SettingsViewModel!
    
    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        self.viewModel = SettingsViewModel()
        self.viewModel.coordinatorDelegate = self
    }
    
    // MARK: - Public Methods
    func testGetStoredUnitSuccess() {
        UserDefaults.standard.set(Unit.kelvin.rawValue, forKey: "unit")
        let unit = self.viewModel.getStoredUnit()
        XCTAssertEqual(unit, Unit.kelvin)
    }
    
    func testGetStoredUnitFailure() {
        let unit = self.viewModel.getStoredUnit()
        XCTAssertEqual(unit, Unit.celsius)
    }
    
    func testSelectUnit() {
        self.viewModel.selectUnit(.celsius)
        XCTAssert(delegateWasCalled)
    }
}

extension SettingsViewModelTests: SettingsViewModelCoordinatorDelegate {
    func didSelectUnit() {
        delegateWasCalled = true
    }
}
