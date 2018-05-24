//
//  TextForecast.swift
//  lab6
//
//  Created by Local Account 436-02 on 4/30/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import Foundation

struct TextForecast : Codable {
    var forecastDays : [ForecastDay]
    
    private enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
    
    struct ForecastDay : Codable {
        var date : dateVal
        var icon_url : String
        var conditions : String
        var high : highVal
        var low : lowVal
        var avewind : avgWindVal
        var maxwind : maxWindVal
        
        private enum CodingKeys: String, CodingKey {
            case date
            case high
            case low
            case icon_url
            case conditions
            case maxwind
            case avewind
        }
        
        struct dateVal : Codable {
            var day : Int
            var month : Int
            var year : Int
            var weekday : String
            
            private enum CodingKeys: String, CodingKey {
                case day
                case month
                case year
                case weekday
            }
        }
        
        struct highVal : Codable {
            var fahrenheit : String
            var celsius : String
            
            private enum CodinKeys: String, CodingKey {
                case fahrenheit
                case celsius
            }
        }
        
        struct lowVal : Codable {
            var fahrenheit : String
            var celsius : String
            
            private enum CodinKeys: String, CodingKey {
                case fahrenheit
                case celsius
            }
        }
        
        struct avgWindVal : Codable {
            var mph : Int
            var dir : String
            
            private enum CodinKeys: String, CodingKey {
                case mph
                case dir
            }
        }
        
        struct maxWindVal : Codable {
            var mph : Int
            var dir : String
            
            private enum CodinKeys: String, CodingKey {
                case mph
                case dir
            }
        }
    }
}
