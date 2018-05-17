    //
//  Workout.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import Foundation

class Workout: NSObject {
    
    var name: String
    var reps: String
    var sets: String
    var maxWeight: String
    
    init(name: String, reps: String, sets: String, maxWeight: String) {
        self.reps = reps
        self.name = name
        self.sets = sets
        self.maxWeight = maxWeight
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "sets" : sets,
            "reps" : reps,
            "maxWeight" : maxWeight
        ]
    }
}
