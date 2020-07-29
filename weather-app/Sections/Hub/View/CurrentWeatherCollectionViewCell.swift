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

    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    private var weatherConditionAnimation = AnimationView()

    // MARK: - Private Methods
    private func addAnimation(_ animation: String) {
        let animation = Animation.named(animation)
        
        weatherConditionAnimation.animation = animation
        weatherConditionAnimation.contentMode = .scaleAspectFit
        weatherConditionAnimation.frame = animationView.bounds
        weatherConditionAnimation.loopMode = .loop
        weatherConditionAnimation.play()
        
        animationView.addSubview(weatherConditionAnimation)
    }
    
    private func getDate() -> String? {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: date)
    }
    
    private func setupLabels(_ weather: CurrentWeather) {
        self.cityNameLabel.text = weather.name
        self.weatherConditionLabel.text = weather.weather[0].description.capitalized
        self.temperatureLabel.text = String(format: "%.0f", weather.main.temp)
        self.dateLabel.text = getDate()
    }
    
    // MARK: - Public Methods
    func setup(_ weather: CurrentWeather) {
        self.setupLabels(weather)
        guard let weather = weather.weather.first else { return }
        self.addAnimation(weather.condition.rawValue)
    }
}
