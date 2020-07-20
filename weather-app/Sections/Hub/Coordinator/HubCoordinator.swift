//
//  HubCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
import UIKit

class HubCoordinator: Coordinator {
    
    private var viewController: HubViewController?
    private var window: UIWindow
    
    required init(viewController: HubViewController, window: UIWindow) {
        self.window = window
        self.viewController = viewController
    }
    
    func start() {
        guard let viewController = viewController else { return }
        window.rootViewController = viewController
    }
    
    func stop() {
        viewController = nil
    }
}
