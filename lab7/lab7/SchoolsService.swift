//
//  SchoolsService.swift
//  lab7
//
//  Created by Elie Saliba on 5/10/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import Foundation

struct SchoolsService : Codable {
    var schools : [School]
    
    struct School : Codable {
        var name :  String?
        var city :  String?
        var state : String?
        var zip : String?
        var contact_email : String?
        var latitude : Double?
        var longitude : Double?
    }
}
