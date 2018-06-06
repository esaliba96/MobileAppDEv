//
//  WorkoutEdit.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/17/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WorkoutEditVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataFromTable : Workout?
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var setsTF: UITextField!
    @IBOutlet weak var repsTF: UITextField!
    @IBOutlet weak var restTF: UITextField!
    var workoutNames = [String]()
    @IBOutlet weak var pickerworkout: UIPickerView!
    var workoutRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutRef = Database.database().reference(withPath: "workouts")
        if dataFromTable != nil {
            nameTF.text = dataFromTable?.name
            repsTF.text = dataFromTable?.reps
            setsTF.text = dataFromTable?.sets
            restTF.text = dataFromTable?.maxWeight
        }
        getWorkoutNames()
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workoutNames.count;
    }
    
    func getWorkoutNames() {
        workoutRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.workoutRef?.child(key).observe(.value, with:
                    { snapshot in
                        
                        var newWorkouts = [Workout]()
                        
                        for item in snapshot.children {
                            newWorkouts.append(Workout(snapshot: item as! DataSnapshot))
                             self.workoutNames.append(Workout(snapshot: item as! DataSnapshot).name)
                            self.pickerworkout.reloadAllComponents()
                        }
                })
            }
        })
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workoutNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTF.text = workoutNames[pickerworkout.selectedRow(inComponent: 0)]
    }
    
}
