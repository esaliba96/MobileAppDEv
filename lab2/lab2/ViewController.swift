//
//  ViewController.swift
//  lab2
//
//  Created by Local Account 436-02 on 4/6/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var segField: UISegmentedControl!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelForSlider: UILabel!
    fileprivate func extractedFunc(_ sender: UISegmentedControl) {
        labelText.text = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }
    @IBOutlet weak var sliderVal: UISlider!
    
    @IBAction func segControl(_ sender: UISegmentedControl) {
        extractedFunc(sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        extractedFunc(segField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sliderAction(_ sender: UISlider) {
        if (sender.value < 33) {
            labelForSlider.textColor = .red
        } else if (sender.value  > 33 && sender.value < 66) {
            labelForSlider.textColor = .yellow
        } else {
            labelForSlider.textColor = .green
        }
    }
    @IBOutlet weak var textFielfOut: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFielfOut.text = textField.text
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
}

