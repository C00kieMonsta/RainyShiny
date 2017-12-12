//
//  WeatherCell.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func configureCell(forecastWeater: ForecastWeather){
        weatherImage.image = UIImage(named: forecastWeater.weatherStatus)
        dateLabel.text = forecastWeater.date
        weatherStatusLabel.text = forecastWeater.weatherStatus
        maxTempLabel.text = "\(forecastWeater.highCelsiusTemp)º"
        minTempLabel.text = "\(forecastWeater.lowCelsiusTemp)º"
    }
    
}
