//
//  FoodTVCell.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import Charts

class FoodTVCell : UITableViewCell {
    
    @IBOutlet weak var chart : PieChartView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
        colors.append(UIColor(red: CGFloat(86.0/255), green: CGFloat(255.0/255), blue: CGFloat(210.0/255), alpha: 1))
        colors.append(UIColor(red: CGFloat(254.0/255), green: CGFloat(35.0/255), blue: CGFloat(6.0/255), alpha: 1))
        colors.append(UIColor(red: CGFloat(107.0/255), green: CGFloat(114.0/255), blue: CGFloat(161.0/255), alpha: 1))
        colors.append(UIColor(red: CGFloat(20.0/255), green: CGFloat(201.0/255), blue: CGFloat(74.0/255), alpha: 1))

        
        pieChartDataSet.colors = colors
        
    }

}
