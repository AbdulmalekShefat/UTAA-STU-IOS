//
//  AddButtonTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 04/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class AddButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var addLecture: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CustomizeView.dropShadow(layer: addLecture.layer, radius: 2, height: 2, opacity: 0.48)
        
        setButtonTouchListener(button: addLecture)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setButtonTouchListener(button: UIButton){
        button.addTarget(self, action: #selector(holdDown(sender:)), for: UIControlEvents.touchDown)
    }
    
    func holdDown(sender: UIButton){
        CustomizeView.dropShadow(layer: sender.layer,radius: 4, height: 2, width: 0)
    }

}
