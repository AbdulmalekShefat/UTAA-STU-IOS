//
//  ColorsTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 02/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CustomizeView.dropShadow(layer: (self.contentView.superview?.layer)!, radius: 4, height: -2.0, width: 0, opacity: 0.25)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
