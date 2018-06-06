//
//  SignUp.swift
//  FinalApp
//
//  Created by Elie Saliba on 6/6/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignUp: UIViewController {
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().isPersistenceEnabled = true
        
        image.image = UIImage(named: "tough.png")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "register" {
            (segue.destination as? ViewController)?.user = user.text
        }
    }
}
