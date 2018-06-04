//
//  ViewController.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/15/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import JTAppleCalendar
import FirebaseDatabase

class ViewController: UIViewController {
    let formatter = DateFormatter()
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    let outsideMonthColor = UIColor.darkGray
    let selectedMonthColor = UIColor.black
    let monthColor = UIColor.black
    var dates =  [String]()
    @IBOutlet weak var item1: UITabBarItem!
    @IBOutlet weak var item2: UITabBarItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Database.database().isPersistenceEnabled = true
        
        calendarView.visibleDates { (visibleDate) in
            self.setupViewsOfCalendar(from: visibleDate)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dataLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dataLabel.textColor = monthColor
            } else {
                validCell.dataLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date  = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.year.text = formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.month.text = formatter.string(from: date)
    }
}

extension ViewController: JTAppleCalendarViewDataSource {

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 04 11")!
        let endDate = formatter.date(from: "2017 06 01")!
        
        let paramaters = ConfigurationParameters(startDate: startDate, endDate : endDate)
        return paramaters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
}

extension ViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        myCustomCell.dataLabel.text = cellState.text
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dataLabel.text = cellState.text
        let test = String(date.description.prefix(10))
        dates.append(test)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = self.calendarView.indexPathsForSelectedItems![0]
        if let tabbarController = segue.destination as? UITabBarController {
            let postVC = tabbarController.viewControllers?.first as? WorkoutTable
              postVC?.currentDate = dates[(cell as NSIndexPath).row]
            let foodVC = tabbarController.viewControllers![1] as? FoodTable
              foodVC?.currentDate = dates[(cell as NSIndexPath).row]

        }
    }
}
