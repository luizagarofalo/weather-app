//
//  HubViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {
    
    var viewModel: HubViewModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(viewModel: HubViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.startLocationManager()
    }
}
