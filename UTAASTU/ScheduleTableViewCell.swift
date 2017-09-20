//
//  CourseTableViewCell.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 02/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contents: UIView!
    
    @IBOutlet weak var section: UIPaddingLabel!
    @IBOutlet weak var name: UIPaddingLabel!
    @IBOutlet weak var code: UIPaddingLabel!
    @IBOutlet weak var place: UIPaddingLabel!
    @IBOutlet weak var time: UIPaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFields(item: LectureItem){
     
        section.text = item.section
        name.text = item.name
        code.text = item.code
        place.text = item.place
        time.text = item.time
        
    }
    
}
