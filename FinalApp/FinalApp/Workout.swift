    //
//  Workout.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Workout: NSObject {
    
    var name: String
    var reps: String
    var sets: String
    var maxWeight: String
    let ref: DatabaseReference?
    
    init(name: String, reps: String, sets: String, maxWeight: String) {
        self.reps = reps
        self.name = name
        self.sets = sets
        self.maxWeight = maxWeight
        self.ref = nil
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "sets" : sets,
            "reps" : reps,
            "maxWeight" : maxWeight
        ]
    }
    
    init(snapshot: DataSnapshot) {
        let snapvalues = snapshot.value as! [String : AnyObject]
        name = snapvalues["name"] as? String ?? "N/A"
        reps = snapvalues["reps"] as? String ?? "N/A"
        sets = snapvalues["sets"] as? String ?? "N/A"
        maxWeight = snapvalues["maxWeight"] as? String ?? "N/A"
        ref = snapshot.ref
    }
}
