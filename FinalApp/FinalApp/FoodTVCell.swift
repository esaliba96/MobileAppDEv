//
//  FoodTVCell.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit

class FoodTVCell : UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var satFat: UILabel!
    @IBOutlet weak var totalFat: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
