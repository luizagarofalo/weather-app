//
//  CurrentWeatherSkeletonCollectionViewCell.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import SkeletonView
import UIKit

class CurrentWeatherSkeletonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradient = SkeletonGradient(baseColor: UIColor.tertiarySystemGroupedBackground)
        view.showAnimatedGradientSkeleton(usingGradient: gradient)
    }
}
