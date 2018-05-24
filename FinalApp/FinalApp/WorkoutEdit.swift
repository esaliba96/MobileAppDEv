//
//  WorkoutEdit.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/17/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit

class WorkoutEditVC: UIViewController, UITextFieldDelegate {
    var dataFromTable : Workout?
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var setsTF: UITextField!
    @IBOutlet weak var repsTF: UITextField!
    @IBOutlet weak var restTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataFromTable != nil {
            nameTF.text = dataFromTable?.name
            repsTF.text = dataFromTable?.reps
            setsTF.text = dataFromTable?.sets
            restTF.text = dataFromTable?.maxWeight
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == restTF {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var repstoadd: String!
        var setstoadd: String!
        var weightoadd: String!
        if segue.identifier == "unwindFromAdd" {
            
            let destVC = segue.destination as? WorkoutTable
            if dataFromTable != nil {
                dataFromTable?.name = nameTF.text!
                dataFromTable?.reps = repsTF.text!
                dataFromTable?.sets = setsTF.text!
                dataFromTable?.maxWeight = restTF.text!
                destVC?.updateCurrent(editedWorkout: dataFromTable!)
            } else {
                if Int(repsTF.text!) != nil {
                    repstoadd = repsTF.text!
                }
                if Int(restTF.text!) != nil {
                    weightoadd = restTF.text!
                }
                if Int(repsTF.text!) != nil {
                    setstoadd = setsTF.text!
                }
                let newWorkout = Workout(name: nameTF.text!, reps: repstoadd, sets: setstoadd, maxWeight: weightoadd)
                destVC?.addWorkout(newWorkout: newWorkout)
            }
        }
    }
    
}
