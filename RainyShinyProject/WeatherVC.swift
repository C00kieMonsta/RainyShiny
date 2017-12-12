//
//  WeatherVC.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "cell"
    
    var currentWeather: CurrentWeather!
    var forecastWeather: ForecastWeather!
    var forecasts = [ForecastWeather]()
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tableview settings
        tableView.delegate = self
        tableView.dataSource = self
        
        // Initialisation of current weather property
        currentWeather = CurrentWeather()
        
        // Location manager settings
        locationManager = CLLocationManager()
        locationManager.delegate = self
        setupLocationManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Ask for authorisation for location
        locationAuthStatus()
        self.tableView.reloadData()
    }
    
    // MARK: - Controller Logic
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        cityLabel.text = currentWeather.location
        temperatureLabel.text = "\(currentWeather.currentCelsiusTemp)º"
        weatherStatusLabel.text =  currentWeather.weatherStatus
        weatherImage.image = UIImage(named: currentWeather.weatherStatus)
    }
    
    func downloadForecastData(completion: @escaping DownloadCompleted){
        let currentWeatherURL = URL(string: FORECAST_WEATHER_URL)// Initialising url to tell Alamofire where to download the data
        Alamofire.request(currentWeatherURL!, method: .get).responseJSON{
            response in
            let result = response.result
            if let mainDict = result.value as? Dictionary<String, Any>{
                if let list = mainDict["list"] as? [Dictionary<String, Any>]{
                    for object in list{
                        let newForecast = ForecastWeather(forecastInfo: object)
                        self.forecasts.append(newForecast)
                    }
                    self.forecasts.remove(at: 0)// We don't want today's date
                }
            }
            completion()
        }
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            LocationSingleton.sharedInstance.latitude = currentLocation.coordinate.latitude
            LocationSingleton.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails { // Update UI
                self.downloadForecastData {
                    self.updateMainUI()
                    self.tableView.reloadData()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
}

// MARK: - Extensions
extension WeatherVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherCell else {return WeatherCell()}
        let forecast = forecasts[indexPath.row]
        cell.configureCell(forecastWeater: forecast)
        return cell
    }
}

extension WeatherVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension WeatherVC: CLLocationManagerDelegate{
    func setupLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
}
