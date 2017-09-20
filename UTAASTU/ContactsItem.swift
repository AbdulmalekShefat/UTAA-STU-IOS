//
//  ContactsItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 31/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation

class ContactsItem {
    
    let TITLE: Int = 0
    let PHONE: Int = 1
    let FAX: Int = 2
    let EMAIL: Int = 3
    let WEBSITE: Int = 4
    
    var title: String = ""
    var label: String = ""
    var content: String = ""
    var type: Int
    
    init(title: String, label: String, content: String) {
        self.title = title
        self.label = label
        self.content = content
        type = -1
        self.getType()
    }
    
    init(dict: NSDictionary) {
        self.title = dict[NCONTACTS_TITLE] as! String
        self.label = dict[NCONTACTS_LABEL] as! String
        self.content = dict[NCONTACTS_CONTENT] as! String
        type = -1
        self.getType()
    }
    
    func getType() {
        if self.title != "" {
            type = TITLE
        } else {
            switch label {
            case "Phone":
                type = PHONE
                break
            case "Email":
                type = EMAIL
                break
            case "Fax":
                type = FAX
                break
            default:
                type = WEBSITE
            }
        }
    }
    
}
