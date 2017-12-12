//
//  CurrentWeather.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    
    // MARK: - Properties (data hiding/data encapsulation)
    private var _cityName: String!
    private var _countryName: String!
    private var _date: String!
    private var _weatherStatus: String!
    private var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = "unknown"
        }
        return _cityName
    }
    
    var countryName: String{
        if _countryName == nil{
            _countryName = "unknown"
        }
        return _countryName
    }
    
    var location: String{
        return "\(cityName), \(countryName)"
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium // "Nov 13, 2016"
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherStatus: String{
        if _weatherStatus == nil{
            _weatherStatus = "unknown"
        }
        return _weatherStatus
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var currentCelsiusTemp: Double {
        if _currentTemp == nil{
             return 0.0
        }
        return Double(round(10 * (_currentTemp - 273.15))/10)
    }
    
    // MARK: - Model Logic 
    func downloadWeatherDetails(comletion: @escaping DownloadCompleted){
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)// Initialising url to tell Alamofire where to download the data
        Alamofire.request(currentWeatherURL!, method: .get).responseJSON{
            response in
            let result = response.result
            if let mainDict = result.value as? Dictionary<String, Any>{
                if let cityName = mainDict["name"] as? String{
                    self._cityName = cityName.capitalized
                }
                if let sysDict = mainDict["sys"] as? Dictionary<String, Any>{
                    if let countryName = sysDict["country"] as? String{
                        self._countryName = countryName
                    }
                }
                if let weatherArray = mainDict["weather"] as? [Dictionary<String, Any>]{
                    if let weatherStatus = weatherArray[0]["main"] as? String{
                        self._weatherStatus = weatherStatus.capitalized
                    }
                }
                if let mainDict = mainDict["main"] as? Dictionary<String, Any>{
                    if let currentTemp = mainDict["temp"] as? Double{
                        self._currentTemp = currentTemp
                    }
                }
            }
            comletion() // Attention de bien mettre la completion dans la closure
        }
    }
}


