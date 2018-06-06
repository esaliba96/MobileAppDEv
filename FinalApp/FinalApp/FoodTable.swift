//
//  FoodTable.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class FoodTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var foods = [Food]()
    var foodRef : DatabaseReference?
    var currentDate : String?
    @IBOutlet weak var chart : PieChartView!
    var totalCal = Double()
    @IBOutlet weak var item2: UITabBarItem!
    var user : String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = currentDate
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
        self.tabBarController?.tabBar.barTintColor = UIColor.white
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
        
        cell.name.text = this.name

        cell.fatText.text = String(describing: this.protein)
        cell.carbsText.text = String(describing: this.totalFat)
        cell.protText.text = String(describing: this.carbs)
        
        return cell
    }
    
    @IBAction func showProgress(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodRef = Database.database().reference(withPath: "food" + "-" + user!)
        item2.image = UIImage(named: "food.png")?.withRenderingMode(.alwaysOriginal)
        setRetrieveCallback()
    }
    
    func setRetrieveCallback() {
        foodRef?.child(currentDate!).observe(.value, with:
            { snapshot in
                
                var newFoods = [Food]()
                
                for item in snapshot.children {
                    let toBeAdded = Food(snapshot: item as! DataSnapshot)
                    newFoods.append(toBeAdded)
                    self.totalCal += toBeAdded.calories
                    let months = ["consumed", "allowed"]
                    let total = 5000.0
                    let percentages = [self.totalCal/total, (total-self.totalCal)/total]
                    self.setChart(dataPoints: months, values: percentages)
                }
                if newFoods.count == 0 {
                    self.chart.isHidden = true
                } else {
                    self.chart.isHidden = false
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
                (segue.destination as! FoodDetail).this = foods[(indexPath as NSIndexPath).row]
            }
        }
        
        if segue.identifier == "progress" {
            (segue.destination as! Progress).currentDate = self.currentDate
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let foodToDelete = foods[(indexPath as NSIndexPath).row]
            foods.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let newRef = foodRef?.child(currentDate!).child(String(foodToDelete.name.prefix(10)))
            newRef?.removeValue()
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: values[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        chart.chartDescription?.text = ""
        chart.legend.enabled = false
        chart.drawHoleEnabled = false
        chart.frame.size = CGSize(width: 500, height: chart.frame.size.height)
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chart.data = pieChartData
        
        var colors: [UIColor] = []
        
        colors.append(UIColor(red: CGFloat(88.0/255), green: CGFloat(170.0/255), blue: CGFloat(213.0/255), alpha: 1))
        colors.append(UIColor(red: CGFloat(129.0/255), green: CGFloat(84.0/255), blue: CGFloat(91.0/255), alpha: 1))
        colors.append(UIColor(red: CGFloat(20.0/255), green: CGFloat(201.0/255), blue: CGFloat(74.0/255), alpha: 1))
        
        pieChartDataSet.colors = colors
        
    }
}
