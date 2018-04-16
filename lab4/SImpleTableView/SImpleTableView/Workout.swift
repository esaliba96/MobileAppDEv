//
//  TacoStand.swift
//  SImpleTableView
//
//  Created by R on 7/5/17.
//  Copyright © 2017 R. All rights reserved.
//


import Foundation

class Workout {
    
    var name: String
    var reps: Int
    var sets: Int
    var maxWeight: Int
    
    init(name: String, reps: Int, sets: Int, maxWeight: Int) {
        self.reps = reps
        self.name = name
        self.sets = sets
        self.maxWeight = maxWeight
    }
}
