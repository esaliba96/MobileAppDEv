//
//  NewFood.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit

class NewFood: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchInput: UITextField!
    let apiFoodID = "https://api.nutritionix.com/v1_1/search/apple?results=0%3A2&cal_min=0&cal_max=5000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=1385c4d5&appKey=0524b7bc56759c31ff6b3c25b0835897"
    let apiFood = "https://api.nutritionix.com/v1_1/item?id=513fceb475b8dbbc21000f95&appId=1385c4d5&appKey=0524b7bc56759c31ff6b3c25b0835897"
    var foodID : FoodIDService?
    var food : FoodService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func search(_ sender: UIButton) {
        print("here")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: apiFoodID)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let foodID = try decoder.decode(FoodIDService.self, from: data)
                    
                    self.foodID = foodID
                    self.getFoodName()
                    DispatchQueue.main.async {
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
            print(self.foodID?.hits[0]._id ?? 0)
        }
        task.resume()
    }
    
    func getFoodName() {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: self.apiFood)!)

        let task1: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in

            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let food = try decoder.decode(FoodService.self, from: data)

                    self.food = food
                    let newFood = Food(food: self.food!)
                    print(newFood.name, newFood.calories)
                    DispatchQueue.main.async {
                    }

                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task1.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromAdd" {
            let destVC = segue.destination as? FoodTable
            let newFood = Food(food: food!)
            print(newFood.calories)
            destVC?.addFood(newFood: newFood)
        }
    }
}
