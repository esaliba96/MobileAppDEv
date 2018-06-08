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

    var foodID : FoodIDService?
    var food : FoodService?
    var foodToBeAdded : Food?
    var foodNames = [String]()
    var foods = [Food]()
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodNameTxt.text = ""
        proteinTxt.text = ""
        satFatTxt.text = ""
        totalFatTxt.text = ""
        carbsTxt.text = ""
        sugarTxt.text = ""
        calText.text  = ""
    }
    
    
    @IBAction func search(_ sender: UIButton) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let newText = searchInput.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let apiFoodID = "https://api.nutritionix.com/v1_1/search/" + newText! + "?results=0%3A6&cal_min=0&cal_max=5000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=1385c4d5&appKey=0524b7bc56759c31ff6b3c25b0835897"
        
        
        let request = URLRequest(url: URL(string: apiFoodID)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let foodID = try decoder.decode(FoodIDService.self, from: data)
                    
                    self.foodID = foodID
                    self.getFoods()
                    //self.getFoodName(nbr: 0)
                    DispatchQueue.main.async {
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
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
                        self.foodNames.append(String(newFood.name.prefix(40)))
                        self.picker.reloadComponent(0)
                        self.populateText(newFood: self.foods[0])
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
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "unwindFromAdd" {
            if (foodToBeAdded == nil) {
                let alertController = UIAlertController(
                    title: "Alert",
                    message: "Food was not added in order to be saved",
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                present(alertController, animated: true, completion: nil)
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromAdd" {
            let destVC = segue.destination as? FoodTable
            destVC?.addFood(newFood: foodToBeAdded!)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return foodNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newFood = foods[picker.selectedRow(inComponent: 0)]
        populateText(newFood: newFood)
    }
    
    func populateText(newFood: Food) {
        foodToBeAdded = newFood
        foodNameTxt.text = String(newFood.name.prefix(25).components(separatedBy: ",")[0])
        proteinTxt.text = String(newFood.protein)
        satFatTxt.text = String(newFood.saturateFat)
        totalFatTxt.text = String(newFood.totalFat)
        carbsTxt.text = String(newFood.carbs)
        sugarTxt.text = String(newFood.sugars)
        calText.text  = String(newFood.calories)
    }
    
}
