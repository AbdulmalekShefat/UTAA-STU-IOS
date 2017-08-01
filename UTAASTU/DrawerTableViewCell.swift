//
//  DrawerTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 29/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class DrawerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initiate(icon: String, label: String){
        self.icon.image = UIImage(named: icon)?.imageWithColor(UIColor.MaterialColors.Primary.blue700)
        self.label.text = label
    }

}
