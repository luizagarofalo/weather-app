//
//  SearchViewModelTests.swift
//  weather-appTests
//
//  Created by Luiza Collado Garofalo on 07/08/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import CoreLocation
import XCTest
@testable import weather_app

class SearchViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var locationManager: CLLocationManagerMock!
    var viewModel: SearchViewModel!
    var delegateDidSelectCityWasCalled = false
    var delegateDidSelectCurrentLocationWasCalled = false

    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        self.locationManager = CLLocationManagerMock(desiredStatus: .denied)
        self.viewModel = SearchViewModel()
        self.viewModel.coordinatorDelegate = self
        self.viewModel.locationManager = locationManager
        self.viewModel.locationManager.delegate = viewModel
    }
    
    override func tearDown() {
        self.locationManager = nil
        self.viewModel = nil
        self.delegateDidSelectCityWasCalled = false
        self.delegateDidSelectCurrentLocationWasCalled = false
        super.tearDown()
    }
    
    // MARK: - Public Methods
    func testSearchCity() {
        self.viewModel.searchCity("São Paulo")
        XCTAssert(delegateDidSelectCityWasCalled)
    }
    
    func testUseCurrentLocationSuccess() {
        self.locationManager.status = .authorizedWhenInUse
        self.viewModel.useCurrentLocation()
        XCTAssert(delegateDidSelectCurrentLocationWasCalled)
    }
    
    func testUseCurrentLocationFailure() {
        self.locationManager.status = .denied
        self.viewModel.useCurrentLocation()
        XCTAssertFalse(delegateDidSelectCurrentLocationWasCalled)
    }
}

extension SearchViewModelTests: SearchViewModelCoordinatorDelegate {
    func didSelectCity(_ name: String) {
        self.delegateDidSelectCityWasCalled = true
    }
    
    func didSelectCurrentLocation(latitude: String, longitude: String) {
        self.delegateDidSelectCurrentLocationWasCalled = true
    }
}
