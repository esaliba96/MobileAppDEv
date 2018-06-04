//
//  FoodDetail.swift
//  FinalApp
//
//  Created by Elie Saliba on 6/4/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import Charts

class FoodDetail: UIViewController {
    @IBOutlet weak var satFatTxt: UILabel!
    @IBOutlet weak var totalFatTxt: UILabel!
    @IBOutlet weak var calText: UILabel!
    @IBOutlet weak var proteinTxt: UILabel!
    @IBOutlet weak var foodNameTxt: UILabel!
    @IBOutlet weak var carbsTxt: UILabel!
    @IBOutlet weak var sugarTxt: UILabel!
    var this : Food!
    @IBOutlet weak var chart : PieChartView!
    
    override func viewDidLoad() {
        foodNameTxt.text = String(this.name.prefix(25).components(separatedBy: ",")[0].components(separatedBy: "(")[0])
        proteinTxt.text = String(describing: this.protein)
        satFatTxt.text = String(describing: this.saturateFat)
        totalFatTxt.text = String(describing: this.totalFat)
        carbsTxt.text = String(describing: this.carbs)
        sugarTxt.text = String(describing: this.sugars)
        calText.text  = String(describing: this.calories)
        
        let months = ["carb", "protein","Fat"]
        let total = this.carbs*4 + this.protein*4 + this.totalFat*9
        let percentages = [(this.carbs*4)/total, (this.protein*4)/total, (this.totalFat*9)/total]
        self.setChart(dataPoints: months, values: percentages)
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
