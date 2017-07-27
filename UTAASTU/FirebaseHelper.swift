//
//  FirebaseHelper.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 24/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {
    
    
    class func error2String(error: AuthErrorCode) -> String {
        
        switch error {
            
        case .emailAlreadyInUse:
            return "email is already taken"
        case .invalidEmail:
            return "invalid email"
        case .weakPassword:
            return "password is weak, try stronger one"
        case .wrongPassword:
            return "password is wrong"
        case .userDisabled:
            return "your account was susbended, contact us for more information"
        case .userNotFound:
            return "email is not registered"
        default:
            return "couldn't connect, please try again"
        }
        
    }
    
}

