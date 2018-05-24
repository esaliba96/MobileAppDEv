//
//  ForecastCell.swift
//  lab6
//
//  Created by Local Account 436-02 on 4/30/18.
//  Copyright © 2018 Local Account 436-02. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var conditionsText: UILabel!
    @IBOutlet weak var highText: UILabel!
    @IBOutlet weak var lowText: UILabel!
    @IBOutlet weak var maxWindText: UILabel!
    @IBOutlet weak var avgWindText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
