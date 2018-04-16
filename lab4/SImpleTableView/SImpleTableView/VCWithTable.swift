//
//  VCWithTable.swift
//  SImpleTableView
//
//  Created by R on 10/10/16.
//  Copyright © 2016 R. All rights reserved.
//

// Basic framework for a UIViewController subclass with a table view

// Uncomment DataSource and Delegate and then implement methods

// Make sure to control-drag from table view to create outlet

import UIKit

class VCWithTable: UIViewController/*, UITableViewDataSource, UITableViewDelegate */ {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
