//
//  UIColor+MaterialColors.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 25/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }

    struct MaterialColors{
        
        
        struct Primary {
            static let blue200 = UIColor(hex: "90CAF9")
            static let blue500 = UIColor(hex: "2196F3")
            static let blue700 = UIColor(hex: "1976D2")
            static let blue900 = UIColor(hex: "0D47A1")
            static let blueA700 = UIColor(hex: "2962FF")
        }
        
        struct SignIn {
            static let red200 = UIColor(hex: "EF9A9A")
            static let red500 = UIColor(hex: "F44336")
            static let red700 = UIColor(hex: "D32F2F")
            static let redA700 = UIColor(hex: "D50000")
        }
        
        struct Accent {
            static let orange200 = UIColor(hex: "FFAB91")
            static let orange500 = UIColor(hex: "FF9800")
            static let orange700 = UIColor(hex: "E64A19")
            static let orangeA700 = UIColor(hex: "DD2C00")
        }
        
    }



}
