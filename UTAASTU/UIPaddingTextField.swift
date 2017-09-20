//
//  UIPaddingTextField.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 03/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class UIPaddingTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(2, 4, 2, 4))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(2, 4, 2, 4))
    }

}
