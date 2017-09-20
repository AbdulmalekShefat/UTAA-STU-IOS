//
//  ProfileData.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 30/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import KRProgressHUD
import Firebase

class ProfileData {
    
    let email: String
    let uid: String
    var name: String
    var birthDate: String
    var phoneNumber: String
    var profilePicture: String
    var department: Int
    
    init(name: String = "", birthDate: String = "", phoneNumber: String = "", profilePicture: String = "", department: Int = 0) {
        self.email = (Auth.auth().currentUser?.email!)!
        self.uid = (Auth.auth().currentUser?.uid)!
        self.name = name
        self.birthDate = birthDate
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.department = department
    }
    
    init(dictionary: NSDictionary) {
        email = (Auth.auth().currentUser?.email!)!
        name = (Auth.auth().currentUser?.displayName!)!
        uid = (Auth.auth().currentUser?.uid)!
        birthDate = dictionary[KUSERS_BIRTHDATE] as! String
        phoneNumber = dictionary[KUSERS_PHONE] as! String
        profilePicture = dictionary[KUSERS_PHOTO] as! String
        department = dictionary[KUSERS_DEPARTMENT] as! Int
    }
    
    func item2Dic(item: ProfileData) -> NSDictionary {
        return NSDictionary(objects:
            [item.name, item.email, item.birthDate, item.phoneNumber, item.profilePicture, item.department],
                            forKeys:
            [KUSERS_NAME as NSCopying, KUSERS_EMAIL as NSCopying, KUSERS_BIRTHDATE as NSCopying, KUSERS_PHONE as NSCopying, KUSERS_PHOTO as NSCopying, KUSERS_DEPARTMENT as NSCopying]
        
        )
    }
    
    func updateUserProfile(completion: @escaping (_ error: Error?) -> Void){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.name
        changeRequest?.commitChanges(completion: {(error) in
            
            completion(error)
        
        })
    }
    
    func updateUserDatabase(completion: @escaping (_ error: Error?) -> Void){
        
        let ref = database.child(KUSERS).child(uid)
        ref.setValue(item2Dic(item: self)) {
            (error, ref) -> Void in
            
            completion(error)
            
        }
        
    }
    
    
    
}
