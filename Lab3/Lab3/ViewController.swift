//
//  ViewController.swift
//  Lab3
//
//  Created by Local Account 436-02 on 4/11/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var slo = [String]();
    var atascadero = [String]();
    var arroryo = [String]();
    let cities = ["San Luis Obispo", "Atascadero", "Arroyo Grande"].sorted()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let row = pickerView.selectedRow(inComponent: 0)
        
        if component == 0 {
            return cities.count
        } else if component == 1 {
            if row == 0 {
                return arroryo.count
            } else if row == 1 {
                return atascadero.count
            } else if row == 2 {
                return slo.count
            }
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let selecRow = pickerView.selectedRow(inComponent: 0)
        
        if component == 0 {
            return cities[row]
        }
        else if component == 1 {
            if selecRow == 0 {
                return arroryo[row]
            } else if selecRow == 1 {
                return atascadero[row]
            } else if selecRow == 2 {
                return slo[row]
            }
        }
        
        return "!!!"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cityIndex = pickerView.selectedRow(inComponent: 0)
        let restIndex = pickerView.selectedRow(inComponent: 1)
        
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        
        if cityIndex == 0 {
            pickerLabel.text = cities[0] + " at " + arroryo[restIndex]
        } else if cityIndex == 1 {
            pickerLabel.text = cities[1] + " at " + atascadero[restIndex]
        } else if cityIndex == 2 {
            pickerLabel.text = cities[2] + " at " + slo[restIndex]
        }
    }
    
    
    @IBOutlet weak var pickerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = Bundle.main.url(forResource:"Restaurants",
                                     withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let tempDict = try
                    PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                as! [String:[String]]
                
                slo = tempDict["San Luis Obispo"] as! [String]
                slo = slo.sorted()
                atascadero = tempDict["Atascadero"] as! [String]
                atascadero = atascadero.sorted()
                arroryo = tempDict["Arroyo Grande"] as! [String]
                arroryo.sorted()
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

