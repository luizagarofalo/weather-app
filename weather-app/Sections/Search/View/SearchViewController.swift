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
    private var isButtonEnabled: Bool {
        guard let cityName = searchTextField.text else { return false }
        return !cityName.isEmpty
    }
    
    private var viewModel: SearchViewModel!
    
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
        setupTextField()
    }
    
    // MARK: - Private Methods
    private func enableButton() {
        searchButton.isEnabled = isButtonEnabled
        searchButton.alpha = isButtonEnabled ? 1 : 0.4
    }
    
    private func validateAndProceed() {
        guard let cityName = searchTextField.text, !cityName.isEmpty else { return }
        self.viewModel.searchCity(cityName)
    }
    
    private func setupTextField() {
        _ = searchTextField.resignFirstResponder()
        searchTextField.delegate = self
        searchTextField.returnKeyType = .go
        enableButton()
    }
    
    // MARK: - Actions
    @IBAction func search(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        validateAndProceed()
    }
    
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        viewModel.useCurrentLocation()
    }
}

extension SearchViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        validateAndProceed()
        return true
    }
}
