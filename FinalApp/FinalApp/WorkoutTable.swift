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
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addWorkout", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutRef = Database.database().reference(withPath: "workouts")
        tableView.delegate = self
        tableView.dataSource = self
       // workoutRef?.keepSynced(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkouts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutSched", for: indexPath) as! WorkoutTVCell
        
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
    
}


