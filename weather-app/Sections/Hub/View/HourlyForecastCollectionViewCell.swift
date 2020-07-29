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
    var isLoading = false
    
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
    func setup(_ isLoading: Bool) {
        self.isLoading = isLoading
        self.collectionView.reloadData()
    }
}

extension HourlyForecastCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(of: SingleHourlyForecastCollectionViewCell.self, for: indexPath) { cell in
            cell.setup(self.isLoading)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 115)
    }
}
