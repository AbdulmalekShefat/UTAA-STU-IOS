//
//  ScheduleEditTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 03/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import SwipeCellKit

class ScheduleEditTableViewCell: SwipeTableViewCell{

    
    @IBOutlet weak var section: UIPaddingTextField!
    @IBOutlet weak var name: UIPaddingTextField!
    @IBOutlet weak var code: UIPaddingTextField!
    @IBOutlet weak var place: UIPaddingTextField!
    @IBOutlet weak var time: UIPaddingTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFields(item: LectureItem, delegate: UITextFieldDelegate, tag: Int){
        
        section.text = item.section
        section.tag = tag
        section.delegate = delegate
        name.text = item.name
        name.delegate = delegate
        name.tag = tag + 1
        code.text = item.code
        code.delegate = delegate
        code.tag = tag + 2
        place.text = item.place
        place.delegate = delegate
        place.tag = tag + 3
        time.text = item.time
        time.delegate = delegate
        
    }

}
