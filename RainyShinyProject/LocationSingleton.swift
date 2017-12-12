//
//  LocationSingleton.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import CoreLocation

class LocationSingleton{

    // MARK: - Public property
    static var sharedInstance = LocationSingleton()
    
    // MARK: - Properties
    var latitude: Double!
    var longitude: Double!
    
    // MARK: Private constructor to make it a singleton
    private init(){}
    
    
}
