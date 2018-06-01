//
//  NewFood.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit

class NewFood: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var satFatTxt: UILabel!
    @IBOutlet weak var totalFatTxt: UILabel!
    @IBOutlet weak var calText: UILabel!
    @IBOutlet weak var proteinTxt: UILabel!
    @IBOutlet weak var foodNameTxt: UILabel!
    @IBOutlet weak var carbsTxt: UILabel!
    @IBOutlet weak var sugarTxt: UILabel!
    var dataFromTable : Food!
    @IBOutlet weak var canceButton: UIButton!
    @IBOutlet weak var sabeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    var foodID : FoodIDService?
    var food : FoodService?
    var foodNames = [String]()
    var foods = [Food]()
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataFromTable != nil {
            foodNameTxt.text = dataFromTable.name.components(separatedBy: "(")[0]
            proteinTxt.text = String(describing: dataFromTable.protein)
            satFatTxt.text = String(describing: dataFromTable.saturateFat)
            totalFatTxt.text = String(describing: dataFromTable.totalFat)
            carbsTxt.text = String(describing: dataFromTable.carbs)
            sugarTxt.text = String(describing: dataFromTable.sugars)
            calText.text  = String(describing: dataFromTable.calories)
            searchInput.isHidden = true
            canceButton.isHidden = true
            sabeButton.isHidden = true
            searchButton.isHidden = true
        } else {
            foodNameTxt.text = ""
            proteinTxt.text = ""
            satFatTxt.text = ""
            totalFatTxt.text = ""
            carbsTxt.text = ""
            sugarTxt.text = ""
            calText.text  = ""
        }
    }
    
    
    @IBAction func search(_ sender: UIButton) {
        print("here")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let apiFoodID = "https://api.nutritionix.com/v1_1/search/" + searchInput.text! + "?results=0%3A6&cal_min=0&cal_max=5000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=1385c4d5&appKey=0524b7bc56759c31ff6b3c25b0835897"
        
        let request = URLRequest(url: URL(string: apiFoodID)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let foodID = try decoder.decode(FoodIDService.self, from: data)
                    
                    self.foodID = foodID
                    self.getFoods()
                    self.getFoodName(nbr: 0)
                    DispatchQueue.main.async {
                        self.picker.reloadComponent(0)
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
            print(self.foodID?.hits[0]._id ?? 0)
        }
        task.resume()
    }
    
    func getFoodName(nbr : Int) {
        print(nbr)
        let apiFood = "https://api.nutritionix.com/v1_1/item?id=" + (foodID?.hits[nbr]._id)! + "&appId=1385c4d5&appKey=0524b7bc56759c31ff6b3c25b0835897"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: apiFood)!)

        let task1: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in

            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let food = try decoder.decode(FoodService.self, from: data)

                    self.food = food
                    
                    DispatchQueue.main.async {
                        let newFood = Food(food: self.food!)
                        self.foods.append(newFood)
                        self.foodNames.append(newFood.name.components(separatedBy: "(")[0])
//                        self.foodNameTxt.text = String(newFood.name.components(separatedBy: "(")[0])
//                        self.proteinTxt.text = String(newFood.protein)
//                        self.satFatTxt.text = String(newFood.saturateFat)
//                        self.totalFatTxt.text = String(newFood.totalFat)
//                        self.carbsTxt.text = String(newFood.carbs)
//                        self.sugarTxt.text = String(newFood.sugars)
//                        self.calText.text  = String(newFood.calories)
                    }

                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task1.resume()
    }
    
    func getFoods() {
        for i in 0...5 {
            getFoodName(nbr: i)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromAdd" {
            let destVC = segue.destination as? FoodTable
            let newFood = Food(food: food!)
            print(newFood.calories)
            destVC?.addFood(newFood: newFood)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(foodNames[row])
        return foodNames[row]
    }
    
}
