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
    private func addAnimation(_ animation: String) {
        let animation = Animation.named(animation + "-b")
        
        weatherConditionAnimation.animation = animation
        weatherConditionAnimation.contentMode = .scaleAspectFit
        weatherConditionAnimation.frame = animationView.bounds
        weatherConditionAnimation.loopMode = .loop
        weatherConditionAnimation.play()
        
        animationView.addSubview(weatherConditionAnimation)
    }
    
    private func getTime(_ date: Int, _ timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        dateFormatter.dateFormat = "hh:00"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Public Methods
    func setup(_ isLoading: Bool, _ forecast: HourlyForecast.Hourly?, _ timezone: String) {        
        guard let forecast = forecast else { return }
        self.hourLabel.text = getTime(forecast.dt, timezone)
        self.weatherLabel.text = String(format: "%.0f", forecast.temp) + "º"
        
        guard let weather = forecast.weather.first else { return }
        self.addAnimation(weather.condition.rawValue)
    }
}
