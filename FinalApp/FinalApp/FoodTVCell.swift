//
//  FoodTVCell.swift
//  FinalApp
//
//  Created by Elie Saliba on 5/22/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import Charts

class FoodTVCell : UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fatText: UILabel!
    @IBOutlet weak var carbsText: UILabel!
    @IBOutlet weak var protText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
