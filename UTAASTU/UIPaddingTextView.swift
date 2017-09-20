//
//  UIPaddingTextView.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 02/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class UIPaddingTextView: UITextView {

    let padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    override func textRectForBounds(bounds: CGRect) -> CGRect{
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    

}
