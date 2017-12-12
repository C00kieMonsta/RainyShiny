//
//  ForecastWeather.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import UIKit
import Alamofire

class ForecastWeather{
    
    // MARK: - Properties (data hiding/data encapsulation)
    private var _date: String!
    private var _weatherStatus: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date: String{
        if _date == nil{
            _date =  ""
        }
        return _date
    }
    
    var weatherStatus: String{
        if _weatherStatus == nil{
            _weatherStatus = ""
        }
        return _weatherStatus
    }
    
    var highTemp: Double{
        if _highTemp == nil{
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var highCelsiusTemp: Double {
        if _highTemp == nil{
            return 0.0
        }
        return Double(round(10 * (_highTemp - 273.15))/10)
    }
    
    var lowTemp: Double {
        if _lowTemp == nil{
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    var lowCelsiusTemp: Double {
        if _lowTemp == nil{
            return 0.0
        }
        return Double(round(10 * (_lowTemp - 273.15))/10)
    }
    
    // MARK: - Constructor
    init(forecastInfo: Dictionary<String, Any>){
        if let tempDict = forecastInfo["temp"] as? Dictionary<String, Any>{
            if let highTemp = tempDict["max"] as? Double{
                self._highTemp = highTemp
            }
            if let lowTemp = tempDict["min"] as? Double{
                self._lowTemp = lowTemp
            }
        }
        if let weatherArray = forecastInfo["weather"] as? [Dictionary<String, Any>] {
            if let weatherStatus = weatherArray[0]["main"] as? String{
                self._weatherStatus = weatherStatus
            }
        }
        if let date = forecastInfo["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfWeek()
        }
    }
    
}




