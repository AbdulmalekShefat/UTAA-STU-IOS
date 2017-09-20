//
//  LectureItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 02/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase

class LectureItem {

    var code:       String!
    var name:       String!
    var section:    String!
    var time:       String!
    var place:      String!

    init(code: String = "", name: String = "", section: String = "", time: String = "", place: String = "") {
        
        self.code = code
        self.name = name
        self.place = place
        self.section = section
        self.time = time
    }
    
    init(dic: NSDictionary) {
        self.code = dic[KLECTURE_CODE] as! String
        self.name = dic[KLECTURE_NAME] as! String
        self.place = dic[KLECTURE_PLACE] as! String
        self.section = dic[KLECTURE_SECTION] as! String
        self.time = dic[KLECTURE_TIME] as! String
    }
    
    class func item2Dic(item: LectureItem) -> NSDictionary {
       
        return NSDictionary(objects:
            [item.code, item.name, item.place, item.time, item.section],
                            forKeys:
            [KLECTURE_CODE as NSCopying, KLECTURE_NAME as NSCopying, KLECTURE_PLACE as NSCopying, KLECTURE_TIME as NSCopying, KLECTURE_SECTION as NSCopying]
            
        )
        
    }
    
    class func updateSchedule(days: [DayItem], lectures: [LectureItem], completion: @escaping (_ error: Error?) -> Void){
        
        var prev = 0
        
        let ref = database.child(KLECTURES).child((Auth.auth().currentUser?.uid)!)
        ref.removeValue()
        
        for (index, day) in days.enumerated() {
            
            for lecture in 0..<day.items {
                
                let dayRef = ref.child("\(index+1)\(day.day)").child("lecture_\(lecture+1)")
                
                let dic = item2Dic(item: lectures[prev + lecture])
                
                print(dic[KLECTURE_NAME]!, dic[KLECTURE_TIME]!)
                
                dayRef.setValue(dic, withCompletionBlock: { (error, ref) in
                    
                    completion(error)
                    if error != nil {return}
                    
                })
                
            }
            
            prev += day.items
            
        }
    
        completion(nil)
        
    }

}
