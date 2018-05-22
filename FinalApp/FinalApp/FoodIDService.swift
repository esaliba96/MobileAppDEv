//
//  FoodService.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import Foundation

struct FoodIDService : Codable {

    var hits : [foodID]

    struct foodID : Codable {
        var _id : String?
    }
}
