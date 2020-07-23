//
//  CurrentWeatherCollectionViewCell.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 22/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Lottie
import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var weatherConditionAnimation = AnimationView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addAnimation()
    }
    
    private func addAnimation() {
        let animation = Animation.named("windy")
        
        weatherConditionAnimation.animation = animation
        weatherConditionAnimation.contentMode = .scaleAspectFit
        weatherConditionAnimation.frame = animationView.bounds
        weatherConditionAnimation.loopMode = .loop
        weatherConditionAnimation.play()
        
        animationView.addSubview(weatherConditionAnimation)
    }
}
