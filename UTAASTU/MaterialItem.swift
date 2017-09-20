//
//  MaterialItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 31/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase

class MaterialItem {
    
    var name: String
    var desc: String
    var link: String
    var id: String
    
    init(_name: String, _desc: String, _link: String, _id: String) {
        name = _name
        desc = _desc
        link = _link
        id = _id
    }

    init(dict: NSDictionary) {
        name = dict[NMATERIALS_NAME] as! String
        desc = dict[NMATERIALS_DESC] as! String
        link = dict[NMATERIALS_LINK] as! String
        id = dict[NMATERIALS_ID] as! String
    }
    
    class func item2Dic(item: MaterialItem) -> NSDictionary {
        
        return NSDictionary(objects:
            [item.name, item.desc, item.link],
                            forKeys:
            [NMATERIALS_NAME as NSCopying, NMATERIALS_DESC as NSCopying, NMATERIALS_LINK as NSCopying]
            
        )
        
    }
    
    class func addMaterial(material: MaterialItem, completion: @escaping (_ error: Error?) -> Void){
        
        
        let ref = database.child(KMATERIALS).child(material.name)
        ref.setValue(item2Dic(item: material))
        
        completion(nil)
        
    }
    
    class func removeMaterial(material: String, completion: @escaping (_ error: Error?) -> Void){
        
        
        let ref = database.child(KMATERIALS).child(material)
        ref.removeValue()
        
        completion(nil)
        
    }
    
}
