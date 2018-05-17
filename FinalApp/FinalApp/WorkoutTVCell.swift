//
//  WorkoutTVCell.swift
//  Lab5
//
//  Created by Local Account 436-02 on 4/24/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class WorkoutTVCell: UITableViewCell {
    
    @IBOutlet weak var workoutNameIn: UILabel!
    @IBOutlet weak var setIn: UILabel!
    @IBOutlet weak var repsIn: UILabel!
    @IBOutlet weak var maxIn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
