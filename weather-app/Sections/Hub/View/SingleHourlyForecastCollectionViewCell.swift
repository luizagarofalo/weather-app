//
//  SingleHourlyForecastCollectionViewCell.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 26/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Lottie
import SkeletonView
import UIKit

class SingleHourlyForecastCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
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
    
    private func showSkeleton(_ show: Bool) {
        if show {
            view.showAnimatedSkeleton()
        } else {
            DispatchQueue.main.async {
                self.view.hideSkeleton()
                self.addAnimation()
            }
        }
    }
    
    // MARK: - Public Methods
    func setup(_ isLoading: Bool) {
        self.showSkeleton(isLoading)
    }
}
