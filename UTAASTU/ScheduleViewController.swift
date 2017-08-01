//
//  ScheduleViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 26/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CustomizeView.dropShadow(layer: self.navigationController!.navigationBar.layer)
        
    }

    //  MARK: Toolbar buttons
    
    @IBAction func openLeftMenu(_ sender: Any) {
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    @IBAction func editSchedle(_ sender: Any) {
    }
    
    
}
