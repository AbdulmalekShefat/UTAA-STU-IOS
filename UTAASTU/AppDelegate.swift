//
//  AppDelegate.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 7/22/17.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        
//        do{
//            try Auth.auth().signOut()
//        }catch{
//            print(error.localizedDescription)
//        }
        
        
        if Auth.auth().currentUser == nil{
            //  start 'login' viewController
            
            window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard  = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()
            
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
      
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

