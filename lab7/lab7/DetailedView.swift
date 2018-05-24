//
//  DetailedView.swift
//  lab7
//
//  Created by Elie Saliba on 5/11/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit

class DetailedView : UIViewController {
    var school : School!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel?.text = school.name
        cityLabel?.text = school.city
        stateLabel?.text = school.state
        zipLabel?.text = school.zip
        emailLabel?.text = school.email
        latLabel?.text = String(describing: school.latitude)
        lonLabel?.text =  String(describing: school.longitude)
    }
}
