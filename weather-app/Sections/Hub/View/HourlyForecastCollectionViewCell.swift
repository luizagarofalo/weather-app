//
//  HourlyForecastCollectionViewCell.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 26/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var isLoading = false
    private var forecast: HourlyForecast? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    // MARK: - Private Methods
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.register(SingleHourlyForecastCollectionViewCell.self)
    }
    
    // MARK: – Public Methods
    func setup(_ isLoading: Bool, _ forecast: HourlyForecast?) {
        self.isLoading = isLoading
        self.forecast = forecast
    }
}

extension HourlyForecastCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast?.hourly?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(of: SingleHourlyForecastCollectionViewCell.self, for: indexPath) { cell in
            let timezone = self.forecast?.timezone ?? ""
            cell.setup(self.isLoading, self.forecast?.hourly?[indexPath.row] ?? nil, timezone)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 115)
    }
}
