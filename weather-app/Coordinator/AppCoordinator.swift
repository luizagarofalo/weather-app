//
//  AppCoordinator.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private var hubCoordinator: HubCoordinator?
    private var hubViewModel: HubViewModel?
    private var hubViewController: HubViewController?
    private var window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        hubViewModel = HubViewModel()
        guard let hubViewModel = hubViewModel else { return }
        hubViewController = HubViewController(viewModel: hubViewModel)
        guard let hubViewController = hubViewController else { return }
        hubCoordinator = HubCoordinator(viewController: hubViewController, window: window)
        hubCoordinator?.start()
    }
}
