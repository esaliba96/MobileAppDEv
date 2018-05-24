//
//  ViewController.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("savedWorkouts")

    var myWorkouts = [Workout]()
    var ourDefaults = UserDefaults.standard
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        //myWorkouts.append(Workout(name: "Flat BB Bench Press", reps: "5", sets: "5", maxWeight: "225"))

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        if let lastUpdate = ourDefaults.object(forKey: "lastUpdate") as? Date {
            
            let updateString = dateFormatter.string(from: lastUpdate)
            let dialogString = "Data was last updated:\n\(updateString)"
            
            let dialog = UIAlertController(title: "Data Restored", message: dialogString, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Go Away", style: .cancel, handler: nil)
            dialog.addAction(action)
            
            present(dialog, animated: true, completion: nil)
            
            if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: ViewController.archiveURL.path) as? [Workout] {
                myWorkouts = tempArr
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkouts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutSched", for: indexPath) as! WorkoutTVCell
        
        // Configure the cell...
        let thisWorkout = myWorkouts[(indexPath as NSIndexPath).row]
        cell.workoutNameIn.text = thisWorkout.name
        cell.repsIn.text = String(thisWorkout.reps)
        cell.setIn.text = String(thisWorkout.sets)
        cell.restIn.text = String(thisWorkout.maxWeight)
        
        return cell
        
    }
    func updatePersistentStorage() {
        // persist data
        NSKeyedArchiver.archiveRootObject(myWorkouts, toFile: ViewController.archiveURL.path)
        
        // timestamp last update
        ourDefaults.set(Date(), forKey: "lastUpdate")
    }

    @objc func insertNewObject(_ sender: AnyObject) {
        performSegue(withIdentifier: "addWorkout", sender: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            myWorkouts.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updatePersistentStorage()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func addWorkout(newWorkout : Workout) {
        myWorkouts.append(newWorkout)
        tableView.reloadData()
        updatePersistentStorage()
    }
    
    @IBAction func unwindFromAdd(segue:UIStoryboardSegue) {
        tableView.reloadData()
       // updatePersistentStorage()
    }
    
    @IBAction func unwindFromCancel(segue:UIStoryboardSegue)
    {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showSelectedWorkout" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                (segue.destination as! WorkoutEditVC).dataFromTable = myWorkouts[(indexPath as NSIndexPath).row]
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

