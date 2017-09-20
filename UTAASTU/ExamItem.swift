//
//  ExamItem.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 31/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase

class ExamItem {
    
    var code: String
    var date: String
    var time: String
    var place: String
    var elective: Bool
    
    init(code: String, date: String, time: String, place: String, elective: Bool) {
        self.code = code
        self.date = date
        self.time = time
        self.place = place
        self.elective = elective
    }
    
    init(dict: NSDictionary) {
        self.code = dict[NEXAMS_CODE] as! String
        self.date = dict[NEXAMS_DATE] as! String
        self.time = dict[NEXAMS_TIME] as! String
        self.place = dict[NEXAMS_PLACE] as! String
        self.elective = dict[NEXAMS_ELECTIVE] as! Bool
    }
    
    class func item2Dic(item: ExamItem) -> NSDictionary {
        
        return NSDictionary(objects:
            [item.code, item.date, item.time, item.place, item.elective],
                            forKeys:
            [NEXAMS_CODE as NSCopying, NEXAMS_DATE as NSCopying, NEXAMS_TIME as NSCopying, NEXAMS_PLACE as NSCopying, NEXAMS_ELECTIVE as NSCopying]
            
        )
        
    }
    
    class func updateExams(exams: [ExamItem], department: String, completion: @escaping (_ error: Error?) -> Void){
        
        let ref = database.child(KEXAMS)
        
        for exam in exams {
            
            if exam.elective {
                /* elective course */
                let electivesRef = ref.child(KEXAMS_ELECTIVES).child(exam.code)
                electivesRef.setValue(item2Dic(item: exam))
            }else{
                let departmentRef = ref.child(department).child(exam.code)
                departmentRef.setValue(item2Dic(item: exam))
            }
            
        }
        
        completion(nil)
        
    }
    
}
