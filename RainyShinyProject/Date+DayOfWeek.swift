//
//  Date+DayOfWeek.swift
//  RainyShinyProject
//
//  Created by Antoine Boxho on 02/11/2016.
//  Copyright © 2016 KaraganApp. All rights reserved.
//

import Foundation

extension Date{

    func dayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

}
