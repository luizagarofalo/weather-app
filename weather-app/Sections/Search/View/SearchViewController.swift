//
//  SearchViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Properties
    var viewModel: SearchViewModel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = #imageLiteral(resourceName: "compass")
        self.viewModel = viewModel
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func search(_ sender: UIButton) {
        self.viewModel.searchCity()
    }
    
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        self.viewModel.startLocationManager()
    }
}
