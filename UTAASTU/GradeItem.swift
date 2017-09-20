//
//  GradeItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 31/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation

class GradeItem {
    
    var name: String
    var grade: String
    var credit: String
    
    init(_name: String, _grade: String, _credit: String) {
        name = _name
        grade = _grade
        credit = _credit
    }
    
    init(dict: NSDictionary) {
        name = dict[NGPA_NAME] as! String
        grade = dict[NGPA_GRADE] as! String
        credit = dict[NGPA_CREDIT] as! String
    }
    
}
