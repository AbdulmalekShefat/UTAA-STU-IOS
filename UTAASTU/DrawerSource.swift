//
//  DrawerSource.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 29/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation

func drawerItems() -> [[String:String]] {
    
    return [
        
        ["image": "groups", "label": "Social Groups"],
        ["image": "book", "label": "Studying Materials"],
        ["image": "schedule", "label": "Exam Table"],
        ["image": "academic_calendar", "label": "Academic Calendar"],
        ["image": "contacts", "label": "UTAA Contacts"],
        ["image": "notifications", "label": "Notifications"],
        ["image": "about", "label": "About"],
        ["image": "settings", "label": "Settings"],
    
    ]
    
}

enum CellIndx: Int {
    
    case SOCIAL_GROUPS = 0
    case STUDYING_MATERIAL = 1
    case EXAM_TABLE = 2
    case ACADEMIC_CALENDAR = 3
    case UTAA_CONTACTS = 4
    case NOTIFICATIONS = 5
    case ABOUT = 6
    case SETTINGS = 7
    
}
