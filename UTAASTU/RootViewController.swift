//
//  RootViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 23/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import RESideMenu
import Firebase

class RootViewController: RESideMenu {
    
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        
        self.contentViewShadowColor = UIColor.black
        self.contentViewShadowOffset = CGSize.zero
        self.contentViewShadowOpacity = 0.54;
        self.contentViewShadowRadius = 4;
        self.contentViewShadowEnabled = true;
        
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController")
        self.leftMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuViewController")
        
    }
    
    // MARK: StatusBar style change
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: RESide Delegate Methods
    
    func sideMenu(sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        
        

    }
}
