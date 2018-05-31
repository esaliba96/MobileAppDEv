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
    var currentDate : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = currentDate
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func insertNewObject(_ sender: AnyObject) {
        performSegue(withIdentifier: "addFood", sender: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath) as! FoodTVCell
        let this = foods[indexPath.row]
        
        let months = ["cal", "carb", "protein", "satFat", "tFat", "sug"]
        let total = (this.calories + this.carbs + this.protein + this.saturateFat + this.totalFat + this.sugars)/100.0
        let percentages = [this.calories/total, this.carbs/total, this.protein/total, this.saturateFat/total, this.totalFat/total, this.sugars/total]
        cell.setChart(dataPoints: months, values: percentages)
        cell.name.text = this.name
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodRef = Database.database().reference(withPath: "food")
       setRetrieveCallback()
    }
    
    func setRetrieveCallback() {
        foodRef?.child(currentDate!).observe(.value, with:
            { snapshot in
                
                var newFoods = [Food]()
                
                for item in snapshot.children {
                    newFoods.append(Food(snapshot: item as! DataSnapshot))
                    print(item)
                }
                
                self.foods = newFoods
                self.tableView.reloadData()
        })
    }
    @IBAction func unwindFromAdd(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetailFood" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                (segue.destination as! NewFood).dataFromTable = foods[(indexPath as NSIndexPath).row]
            }
        }
    }
    
    @IBAction func unwindFromCancel(segue:UIStoryboardSegue){}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func addFood(newFood: Food) {
        foods.append(newFood)
        tableView.reloadData()
        addToFirebase(newFood: newFood)
    }
    
    func  addToFirebase(newFood : Food) {
        let newRef = foodRef?.child(currentDate!).child(String(newFood.name.prefix(10)))
        newRef?.setValue(newFood.toAnyObject())
    }
}
