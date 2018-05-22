//
//  Food.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Food : NSObject {
    var name: String
    var calories: Double
    var totalFat: Double
    var saturateFat: Double
    var protein: Double
    var sugars: Double
    var carbs: Double
    let ref: DatabaseReference?

    init(food : FoodService) {
        self.name = food.item_name ?? "N/A"
        self.calories = food.nf_calories ?? 0.0
        self.totalFat = food.nf_total_fat ?? 0.0
        self.saturateFat = food.nf_saturated_fat ?? 0.0
        self.protein = food.nf_protein ?? 0.0
        self.sugars = food.nf_sugars ?? 0.0
        self.carbs = food.nf_total_carbohydrate ?? 0.0
        self.ref = nil
        
        super.init()
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "calories" : calories,
            "carbs" : carbs,
            "totalFat" : totalFat,
            "satFat" : saturateFat,
            "sugars" : sugars,
            "protein" : protein
        ]
    }
}
