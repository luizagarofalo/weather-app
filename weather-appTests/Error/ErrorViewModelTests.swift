//
//  ErrorViewModelTests.swift
//  weather-appTests
//
//  Created by Luiza Collado Garofalo on 06/08/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import XCTest
@testable import weather_app

class ErrorViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var delegateWasCalled = false
    var viewModel: ErrorViewModel!

    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        self.viewModel = ErrorViewModel(error: .network)
        self.viewModel.delegate = self
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.delegateWasCalled = false
        super.tearDown()
    }
    
    // MARK: - Public Methods
    func testTryAgain() {
        self.viewModel.tryAgain()
        XCTAssertTrue(delegateWasCalled)
    }
}

extension ErrorViewModelTests: ErrorViewModelDelegate {
    func didTryAgain() {
        self.delegateWasCalled = true
    }
}
