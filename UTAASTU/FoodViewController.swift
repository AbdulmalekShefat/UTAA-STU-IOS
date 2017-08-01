//
//  FoodViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 26/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CustomizeView.dropShadow(layer: self.navigationController!.navigationBar.layer)
        
    }

    @IBAction func openLeftMenu(_ sender: Any) {
        
        self.sideMenuViewController.presentLeftMenuViewController()
        
    }
}
