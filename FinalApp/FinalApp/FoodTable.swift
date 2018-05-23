//
//  FoodTable.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FoodTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var foods = [Food]()
    var foodRef : DatabaseReference?

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewFood(_ sender: UIButton) {
        performSegue(withIdentifier: "addNewFood", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath) as! FoodTVCell
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // workoutRef?.keepSynced(true)
    }
    
    @IBAction func unwindFromAdd(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func unwindFromCancel(segue:UIStoryboardSegue){}
    
    func addFood(newFood: Food) {
        foods.append(newFood)
        tableView.reloadData()
        addToFirebase(newFood: newFood)
    }
    
    func  addToFirebase(newFood : Food) {
        let newRef = foodRef?.child(newFood.name)
        newRef?.setValue(newFood.toAnyObject())
    }
}
