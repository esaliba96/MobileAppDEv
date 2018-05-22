//
//  FoodService.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import Foundation

struct FoodService : Codable {
    var item_name: String?
    var nf_calories: Double?
    var nf_total_fat: Double?
    var nf_saturated_fat: Double?
    var nf_total_carbohydrate: Double?
    var nf_protein: Double?
    var nf_sugars: Double?
}
