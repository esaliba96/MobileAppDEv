//
//  ExampleTVC.swift
//  SImpleTableView
//
//  Created by R on 10/10/16.
//  Copyright © 2016 R. All rights reserved.
//

// UITableViewController subclass that displays all of the taco stands

// When a row is selected, segue to detail view controller and pass name

import UIKit

class ExampleTVC: UITableViewController {

    var myWorkouts = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create some Taco Stands
        myWorkouts.append(Workout(name: "Flat BB Bench Press", reps: 5, sets: 5, maxWeight: 225))
        myWorkouts.append(Workout(name: "Incline BB Bench Press", reps: 5, sets: 5, maxWeight: 175))
        myWorkouts.append(Workout(name: "Flat Dumbbell Bench Press", reps: 5, sets: 5, maxWeight: 95))
        myWorkouts.append(Workout(name: "Incline Dumbell Bench Press", reps: 5, sets: 5, maxWeight: 85))
        myWorkouts.append(Workout(name: "Dips", reps: 10, sets: 3, maxWeight: 25))
        myWorkouts.append(Workout(name: "Cable Rows", reps: 10, sets: 3, maxWeight: 160))
        myWorkouts.append(Workout(name: "BB Shoulder Press", reps: 5, sets: 5, maxWeight: 135))
        myWorkouts.append(Workout(name: "Dumbbell Shoulder Press", reps: 10, sets: 3, maxWeight: 65))
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTVCell

        // Configure the cell...
        let thisWorkout = myWorkouts[indexPath.row]
        cell.workoutName.text = thisWorkout.name
        cell.repsNumber.text = String(thisWorkout.sets)
        cell.maxWeight.text = String(thisWorkout.maxWeight)
        cell.sets.text = String(thisWorkout.reps)
        
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row: \(indexPath.row)")
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showSelectedStand" {
            let destVC = segue.destination as? ViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC?.dataFromTable = myWorkouts[(selectedIndexPath?.row)!]
        }
        
    }
    
    @IBAction func unwindFromDetail(segue:UIStoryboardSegue) {
    
    }


}
