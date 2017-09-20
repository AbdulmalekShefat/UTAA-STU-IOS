//
//  SocialGroupsItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 31/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase

class SocialGroupsItem {
    
    var name: String
    var desc: String
    var laneguage: String
    var link: String
    var id: String
    
    init(dict: NSDictionary) {
        name = dict[NSocialGroups_NAME] as! String
        desc = dict[NSocialGroups_DESC] as! String
        laneguage = dict[NSocialGroups_LANG] as! String
        link = dict[NSocialGroups_LINK] as! String
        id = (Auth.auth().currentUser!.uid)
    }
    
    class func item2Dic(item: SocialGroupsItem) -> NSDictionary {
        
        return NSDictionary(objects:
            [item.name, item.desc, item.laneguage, item.link, item.id],
                            forKeys:
            [NSocialGroups_NAME as NSCopying, NSocialGroups_DESC as NSCopying, NSocialGroups_LANG as NSCopying, NSocialGroups_LINK as NSCopying, NSocialGroups_ID as NSCopying]
            
        )
        
    }
    
    class func addGroup(group: SocialGroupsItem, completion: @escaping (_ error: Error?) -> Void){
        
        
        let ref = database.child(KSocialGroups).child(group.name)
        ref.setValue(item2Dic(item: group))
        
        completion(nil)
        
    }
    
    class func removeGroup(group: String, completion: @escaping (_ error: Error?) -> Void){
        
        
        let ref = database.child(KSocialGroups).child(group)
        ref.removeValue()
        
        completion(nil)
        
    }
    
}
