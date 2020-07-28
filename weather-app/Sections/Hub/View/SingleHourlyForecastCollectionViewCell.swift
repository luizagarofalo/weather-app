//
//  SingleHourlyForecastCollectionViewCell.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 26/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Lottie
import UIKit

class SingleHourlyForecastCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    // MARK: - Properties
    private var weatherConditionAnimation = AnimationView()
    
    // MARK: - Private Methods
    private func addAnimation() {
        let animation = Animation.named("windy-b")
        
        weatherConditionAnimation.animation = animation
        weatherConditionAnimation.contentMode = .scaleAspectFit
        weatherConditionAnimation.frame = animationView.bounds
        weatherConditionAnimation.loopMode = .loop
        weatherConditionAnimation.play()
        
        animationView.addSubview(weatherConditionAnimation)
    }
    
    // MARK: - Public Methods
    func setup() {
        self.addAnimation()
    }
}
