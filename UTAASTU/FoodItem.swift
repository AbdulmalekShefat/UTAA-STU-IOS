//
//  FoodItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 25/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation

class FoodItem {
    
    var meal:   String
    var cal:    Int
    
    init(meal: String, cal: Int) {
        self.meal = meal
        self.cal = cal
    }
    
    init(dic: NSDictionary){
        self.meal = dic[NFOOD_MEAL] as! String
        self.cal = dic[NFOOD_CAL] as! Int
    }
}
