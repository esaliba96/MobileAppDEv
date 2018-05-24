//
//  TextForecastService.swift
//  lab6
//
//  Created by Local Account 436-02 on 4/30/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import Foundation

struct TextForecastService : Codable {
    let forecast : Forecast
    
    struct Forecast: Codable {
        let simpleforecast : TextForecast
        
    }
    
}
