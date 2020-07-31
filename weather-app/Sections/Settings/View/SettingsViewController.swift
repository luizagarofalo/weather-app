//
//  SettingsViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 30/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var fahrenheitButton: UIButton!
    @IBOutlet weak var celsiusButton: UIButton!
    @IBOutlet weak var kelvinButton: UIButton!
    @IBOutlet weak var whiteView: UIView!
    
    // MARK: - Properties
    private var viewModel: SettingsViewModel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(viewModel: SettingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = #imageLiteral(resourceName: "settings")
        self.viewModel = viewModel
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Private Methods
    private func animate(_ unit: Unit) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.whiteView.frame.origin.y = unit.coordinate
            self.view.layoutIfNeeded()
        })
    }
    
    private func color(_ unit: Unit) {
        celsiusButton.setTitleColor(.white, for: .normal)
        fahrenheitButton.setTitleColor(.white, for: .normal)
        kelvinButton.setTitleColor(.white, for: .normal)
        
        switch unit {
        case .celsius:
            celsiusButton.setTitleColor(.darkBlue, for: .normal)
        case .fahrenheit:
            fahrenheitButton.setTitleColor(.darkBlue, for: .normal)
        case .kelvin:
            kelvinButton.setTitleColor(.darkBlue, for: .normal)
        }
    }
    
    private func setup() {
        let unit = viewModel.getStoredUnit()
        animate(unit)
        color(unit)
    }
    
    // MARK: - Actions
    @IBAction func changeUnit(_ sender: UIButton) {
        guard let label = sender.accessibilityLabel else { return }
        guard let unit = Unit(rawValue: label) else { return }
        
        animate(unit)
        color(unit)
        viewModel.selectUnit(unit)
    }
}
