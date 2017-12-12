//
//  Constants.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import Foundation

// Contants for current weather
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LAT = "lat="
let LON = "&lon="
let APP_ID = "&appid="
let API_KEY = "60e66bf9c95727c760a3f70e1fafffbd"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LAT)\(LocationSingleton.sharedInstance.latitude!)\(LON)\(LocationSingleton.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

// Constants for forecasted weather
let F_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let NUMBER_DAYS = "&cnt="
let MODE = "&mode=json"
let FORECAST_WEATHER_URL = "\(F_BASE_URL)\(LAT)\(LocationSingleton.sharedInstance.latitude!)\(LON)\(LocationSingleton.sharedInstance.longitude!)\(NUMBER_DAYS)10\(MODE)\(APP_ID)\(API_KEY)"


typealias DownloadCompleted = () -> () // basically, this is a closure that will be executed when the function is completed


/*
 
 A type alias declaration introduces a named alias of an existing type into your program. So here we create a type alias for the closure type 
 
 */
