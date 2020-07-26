//
//  ErrorViewModel.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 26/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

protocol ErrorViewModelDelegate: AnyObject {
    func didTryAgain()
}

class ErrorViewModel {
    
    // MARK: - Properties
    var error: CustomError
    weak var delegate: ErrorViewModelDelegate?
    
    // MARK: - Initializers
    init(error: CustomError) {
        self.error = error
    }
    
    // MARK: - Public Methods
    func tryAgain() {
        delegate?.didTryAgain()
    }
}
