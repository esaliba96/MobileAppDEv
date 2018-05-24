    //
//  Workout.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import Foundation

class Workout: NSObject, NSCoding {
    
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
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        reps = aDecoder.decodeObject(forKey: "reps") as! String
        sets = aDecoder.decodeObject(forKey: "sets") as! String
        maxWeight = aDecoder.decodeObject(forKey: "maxWeight") as! String

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(reps, forKey: "reps")
        aCoder.encode(sets, forKey: "sets")
        aCoder.encode(maxWeight, forKey: "maxWeight")
    }
}
