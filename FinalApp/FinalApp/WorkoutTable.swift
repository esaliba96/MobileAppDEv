//
//  WorkoutTable.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/16/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

//
//  ViewController.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WorkoutTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var myWorkouts = [Workout]()
    var workoutRef : DatabaseReference?
    var currentDate : String?
    var user : String?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutRef = Database.database().reference(withPath: "workouts" + "-" + user!)
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.tabBar.items![0].image = UIImage(named: "food.png")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "food.png")?.withRenderingMode(.alwaysOriginal)
        setRetrieveCallback()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = currentDate
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
        self.tabBarController?.tabBar.barTintColor = UIColor.white
    }
    
    @objc func insertNewObject(_ sender: AnyObject) {
        performSegue(withIdentifier: "addWorkout", sender: nil)
    }

    
    func setRetrieveCallback() {
        workoutRef?.child(currentDate!).observe(.value, with:
            { snapshot in
                
                var newWorkouts = [Workout]()
                
                for item in snapshot.children {
                    newWorkouts.append(Workout(snapshot: item as! DataSnapshot))
                }
                
                self.myWorkouts = newWorkouts
                self.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkouts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutSched", for: indexPath) as! WorkoutTVCell
        
        let this = myWorkouts[indexPath.row]
        
        cell.workoutNameIn.text = this.name
        cell.repsIn.text = this.reps
        cell.setIn.text = this.sets
        cell.maxIn.text = this.maxWeight
        
        return cell
        
    }
    
    @IBAction func unwindFromAdd(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func unwindFromCancel(segue:UIStoryboardSegue){}
 
    func addWorkout(newWorkout : Workout) {
        myWorkouts.append(newWorkout)
        tableView.reloadData()
        addToFirebase(newWorkout: newWorkout)
    }
    
    func addToFirebase(newWorkout: Workout) {
        let newRef = workoutRef?.child(currentDate!).child(newWorkout.name)
        newRef?.setValue(newWorkout.toAnyObject())
    }
    
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
    
    func updateCurrent(editedWorkout: Workout) {
        let ref = workoutRef?.child(currentDate!).child(editedWorkout.name)
        ref?.updateChildValues(editedWorkout.toAnyObject() as! [AnyHashable : Any])
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let workoutToDelete = myWorkouts[(indexPath as NSIndexPath).row]
            myWorkouts.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let newRef = workoutRef?.child(currentDate!).child(String(workoutToDelete.name))
            newRef?.removeValue()
        }
    }
    
}


