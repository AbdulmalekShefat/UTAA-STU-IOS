//
//  AnimatedTabBarController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 25/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {
    
    var firstIcon: UIImageView!
    var secIcon: UIImageView!
    var thirdIcon: UIImageView!
    var forthIcon: UIImageView!
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomizeView.dropShadow(layer: self.tabBar.layer, height: -0.5)
        
        firstIcon = setIcons(tag: 0)
        secIcon = setIcons(tag: 1)
        thirdIcon = setIcons(tag: 2)
        forthIcon = setIcons(tag: 3)
    
    }
    
    func setIcons(tag: Int) -> UIImageView {
        let iconParent = self.tabBar.subviews[tag]
        let icon = iconParent.subviews.first as! UIImageView
        icon.contentMode = .center
        return icon
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if currentIndex == item.tag{
            return
        }
        
        var icon : UIImageView!
        
        
        switch item.tag {
        case 1:
            icon = secIcon
            break
        case 2:
            icon = thirdIcon
            break
        case 3:
            icon = forthIcon
            break
        default:
            icon = firstIcon
            break
        }
        
        CustomizeView.shakeView(view: icon)
        
        currentIndex = item.tag
        
    }

}
