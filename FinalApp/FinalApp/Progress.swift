//
//  Progress.swift
//  FinalApp
//
//  Created by Elie Saliba on 6/5/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase

class Progress: UIViewController {
    @IBOutlet weak var chart : LineChartView!
    var foodRef : DatabaseReference?
    var currentDate : String?
    var dates = [String]()
    var cals = [Double]()
    var totalCal = Double()
    var user : String!
    override func viewDidLoad() {
        user = UserDefaults.standard.string(forKey: "username")!
        print(user)
        foodRef = Database.database().reference(withPath: "food-" + user)
        generateDates()
        getCals()
    }
    
    func setChart(cals: [Double]) {
        var lineChartEntry  = [ChartDataEntry]()
        for i in 0..<cals.count {
            
            let value = ChartDataEntry(x: Double(i), y: Double(cals[i]))
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line1)
                
        chart.data = data
    }
    
    func getCals() {
        for cuurendate in dates {
            foodRef?.child(cuurendate).observe(.value, with:
            { snapshot in

                for item in snapshot.children {
                    let food = Food(snapshot: item as! DataSnapshot)
                    self.totalCal += food.calories
                }
                self.cals.append(self.totalCal)
                self.totalCal = 0.0
                self.setChart(cals: self.cals)
            })

        }
    }

    func generateDates() {
        let today = currentDate!
        
        let day = Int(today.suffix(2))!
        
        for i in 1...day {
            if ( i > 0 && i < 10) {
                dates.append(today.prefix(8) + "0" + String(i))
            } else {
                dates.append(today.prefix(8) + String(i))
            }
        }
        print(dates)
    }
}
