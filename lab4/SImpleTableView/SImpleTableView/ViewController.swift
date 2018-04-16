//
//  ViewController.swift
//  SImpleTableView
//
//  Created by R on 10/10/16.
//  Copyright © 2016 R. All rights reserved.
//

// Detail View Controller that displays selected data based on row

import UIKit

class ViewController: UIViewController {

    var dataFromTable : Workout?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var sets: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name.text = dataFromTable?.name
        reps.text = String(dataFromTable!.reps)
        sets.text = String(dataFromTable!.sets)
        weight.text = String(dataFromTable!.maxWeight)
    }

}

