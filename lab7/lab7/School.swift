//
//  School.swift
//  lab7
//
//  Created by Elie Saliba on 5/10/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MapKit

class School : NSObject, MKAnnotation {
    var name : String
    var city : String
    var state : String
    var zip : String
    var email : String
    var latitude: Double
    var longitude : Double
    let ref: DatabaseReference?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return city
    }
    
    init(school : SchoolsService.School) {
        self.name = school.name ?? "N/A"
        self.city = school.city ?? "N/A"
        self.state = school.state ?? "N/A"
        self.zip = school.zip ?? "N/A"
        self.latitude = school.latitude ?? 0.0
        self.longitude = school.longitude ?? 0.0
        self.email = school.contact_email ?? "N/A"
        self.ref = nil
        
        super.init()
    }
    
    init(key: String,snapshot: DataSnapshot) {
        name = key
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        let snapvalues = snaptemp[key] as! [String : AnyObject]
        
        city = snapvalues["city"] as? String ?? "N/A"
        state  = snapvalues["state"] as? String ?? "N/A"
        email = snapvalues["email"] as? String ?? "N/A"
        zip = snapvalues["zip"] as? String ?? "N/A"
        latitude = snapvalues["latitude"] as? Double ?? 0.0
        longitude = snapvalues["longitude"] as? Double ?? 0.0
        
        ref = snapshot.ref
        
        super.init()
    }
    
    init(snapshot: DataSnapshot) {
        name = snapshot.key
        let snapvalues = snapshot.value as! [String : AnyObject]
        print("snapvalues: \(snapvalues)")
        city = snapvalues["city"] as! String
        state = snapvalues["state"] as! String
        email = snapvalues["email"] as! String
        zip = snapvalues["zip"] as! String
        longitude = snapvalues["longitude"] as! Double
        latitude = snapvalues["latitude"] as! Double
        
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "city" : city,
            "state" : state,
            "zip" : zip,
            "email" : email,
            "latitude" : latitude,
            "longitude" : longitude
        ]
    }
}

