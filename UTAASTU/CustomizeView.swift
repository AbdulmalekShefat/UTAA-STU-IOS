//
//  ShadowUtils.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 25/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import UIKit

class CustomizeView {

    class func dropShadow(layer: CALayer, radius: CGFloat = 4.0, height: Double = 0.5, width: Double = 0, opacity: Float = 0.54){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    class func shakeView(view: UIView, autoreverses: Bool = true, duration: CFTimeInterval = 0.1, repeatCount: Float = 2){
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = duration
        anim.repeatCount = repeatCount
        anim.autoreverses = autoreverses
        anim.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 2, y: view.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 2, y: view.center.y))
        view.layer.add(anim, forKey: "position")
        
    }
    
    class func setBorder(layer: CALayer, color: UIColor = UIColor.white, width: CGFloat = 2, radius: CGFloat){
        
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true

    }
    
    //  MARK: Animations
    
    class func ripple(view: UIView){
        fadeBackground(view: view)
        let ripple = CATransition()
        ripple.type = "rippleEffect"
        ripple.duration = 0.5
        view.layer.add(ripple, forKey: nil)
    }
    
    class func fadeBackground(view: UIView){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .autoreverse], animations: {
            view.backgroundColor = UIColor.MaterialColors.Accent.orange500.withAlphaComponent(0.5)
        }, completion: {
            
            (finished: Bool) in
            
            view.backgroundColor = .clear
            
        })
    }
    
}
