//
//  FoodTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 25/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var meal: UILabel!
    @IBOutlet weak var cal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFields(item: FoodItem){
        meal.text = item.meal
        cal.text = "\(item.cal)"
    }

}
