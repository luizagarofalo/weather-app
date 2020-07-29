//
//  HubViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import SkeletonView
import UIKit

class HubViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var errorView: ErrorViewController?
    private var isLoading = true
    var viewModel: HubViewModel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(viewModel: HubViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = #imageLiteral(resourceName: "calendar")
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.isScrollEnabled = !UIDevice().hasNotch
        self.collectionView.register(CurrentWeatherCollectionViewCell.self)
        self.collectionView.register(HourlyForecastCollectionViewCell.self)
        self.collectionView.register(CurrentWeatherSkeletonCollectionViewCell.self)
    }
    
    private func showErrorView(_ error: CustomError) {
        let errorViewModel = ErrorViewModel(error: error)
        errorViewModel.delegate = self
        let errorView = ErrorViewController(viewModel: errorViewModel)
        errorView.view.frame = self.view.bounds
        self.view.insertSubview(errorView.view, aboveSubview: self.collectionView)
        self.view.layoutSubviews()
        self.errorView = errorView
    }
    
    private func removeErrorViewIfNeeded() {
        if errorView != nil {
            errorView?.view.removeFromSuperview()
            errorView = nil
        }
    }
}

extension HubViewController: HubViewModelViewDelegate {
    func didStartLoading() {
        self.isLoading = true
        self.removeErrorViewIfNeeded()
    }
    
    func didFinishLoading(_ request: HubViewModel.Request) {
        switch request {
        case .current:
            self.isLoading = true
            self.viewModel.fetchHourlyForecast()
        case .forecast:
            self.isLoading = false
        }
        
        self.collectionView.reloadData()

    }
    
    func didFinishLoadingWithError(_ error: CustomError) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.showErrorView(error)
        }
    }
}

extension HubViewController: ErrorViewModelDelegate {
    func didTryAgain() {
        self.viewModel.fetchCurrentWeather()
    }
}

extension HubViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if isLoading {
                return collectionView.dequeueReusableCell(of: CurrentWeatherSkeletonCollectionViewCell.self, for: indexPath)
            } else {
                return collectionView.dequeueReusableCell(of: CurrentWeatherCollectionViewCell.self, for: indexPath) { cell in
                    guard let weather = self.viewModel.weather else { return }
                    cell.setup(weather)
                }
            }
        } else {
            return collectionView.dequeueReusableCell(of: HourlyForecastCollectionViewCell.self, for: indexPath) { cell in
                cell.setup(self.isLoading)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenHeight = UIScreen.main.bounds.height
        let height: CGFloat = indexPath.section == 0 ? (screenHeight * 0.65) : (screenHeight * 0.25)
        return CGSize(width: UIScreen.main.bounds.size.width, height: height)
    }
}
