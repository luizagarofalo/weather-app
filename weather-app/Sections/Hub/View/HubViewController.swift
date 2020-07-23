//
//  HubViewController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: HubViewModel!
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(viewModel: HubViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.startLocationManager()
        self.setupCollectionView()
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.register(UINib(nibName: "CurrentWeatherCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CurrentWeatherCollectionViewCell")
    }
}

extension HubViewController: HubViewModelViewDelegate {
    func didStartLoading() {
        // TODO: Add skeleton view.
    }
    
    func didFinishLoading() {
        self.collectionView.reloadData()
    }
    
    func didFinishLoadingWithError() {
        // TODO: Add error view.
    }
}

extension HubViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentWeatherCollectionViewCell",
                                                            for: indexPath) as? CurrentWeatherCollectionViewCell else { return UICollectionViewCell() }
        
        if let weather = self.viewModel.weather {
            cell.setup(weather)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 480)
    }
}
