//
//  HubViewModelTests.swift
//  weather-appTests
//
//  Created by Luiza Collado Garofalo on 06/08/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import XCTest
@testable import weather_app

class HubViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: HubViewModel!
    
    // MARK: - Expectations
    var loadingExpectation: XCTestExpectation!
    var successExpectation: XCTestExpectation!
    var failureExpectation: XCTestExpectation!
    
    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        self.viewModel = HubViewModel()
        self.viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.loadingExpectation = nil
        self.successExpectation = nil
        self.failureExpectation = nil
        super.tearDown()
    }
    
    // MARK: - Public Methods
    func testFetchCurrentWeatherSuccess() {
        let (latitude, longitude) = ("-23.5475", "-46.63611")
        self.loadingExpectation = self.expectation(description: "Loading – Success")
        self.successExpectation = self.expectation(description: "Fetch Current Weather – Success")
        self.viewModel.latitude = latitude
        self.viewModel.longitude = longitude
        self.viewModel.location = .coordinates
        self.viewModel.fetchCurrentWeather()
        self.waitForExpectations(timeout: 10)
    }

    func testFetchCurrentWeatherFailure() {
        self.loadingExpectation = self.expectation(description: "Loading – Success")
        self.failureExpectation = self.expectation(description: "Fetch Current Weather – Failure")
        self.viewModel.location = .coordinates
        self.viewModel.fetchCurrentWeather()
        self.waitForExpectations(timeout: 10)
    }

    func testFetchHourlyForecastSuccess() {
        let (latitude, longitude) = ("-23.5475", "-46.63611")
        self.successExpectation = self.expectation(description: "Fetch Hourly Forecast – Success")
        self.viewModel.latitude = latitude
        self.viewModel.longitude = longitude
        self.viewModel.fetchHourlyForecast()
        self.waitForExpectations(timeout: 10)
    }

    func testFetchHourlyForecastFailure() {
        self.failureExpectation = self.expectation(description: "Fetch Hourly Forecast – Failure")
        self.viewModel.fetchHourlyForecast()
        self.waitForExpectations(timeout: 10)
    }
    
    func testUpdateLocationSuccess() {
        let (latitude, longitude) = ("-23.5475", "-46.63611")
        self.loadingExpectation = self.expectation(description: "Loading – Success")
        self.successExpectation = self.expectation(description: "Update Location – Success")
        self.viewModel.updateLocation(city: "São Paulo", lat: latitude, lon: longitude, location: .coordinates)
        XCTAssertEqual(viewModel.latitude, latitude)
        XCTAssertEqual(viewModel.longitude, longitude)
        self.waitForExpectations(timeout: 10)
    }
    
    func testUpdateLocationFailure() {
        self.loadingExpectation = self.expectation(description: "Loading – Success")
        self.failureExpectation = self.expectation(description: "Update Location – Failure")
        self.viewModel.updateLocation(city: nil, lat: nil, lon: nil, location: .coordinates)
        self.waitForExpectations(timeout: 10)
    }
}

extension HubViewModelTests: HubViewModelViewDelegate {
    func didStartLoading() {
        self.loadingExpectation.fulfill()
    }
    
    func didFinishLoading(_ request: HubViewModel.Request) {
        switch request {
        case .current:
            self.successExpectation.fulfill()
        case .forecast:
            self.successExpectation.fulfill()
        }
    }
    
    func didFinishLoadingWithError(_ error: CustomError) {
        self.failureExpectation.fulfill()
    }
}
