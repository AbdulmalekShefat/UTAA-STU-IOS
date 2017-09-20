//
//  UIPaddingLabel.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 02/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit

class UIPaddingLabel: UILabel {
    
    let topPadding = CGFloat(2)
    let bottomPadding = CGFloat(2)
    let leftPadding = CGFloat(4)
    let rightPadding = CGFloat(4)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topPadding + bottomPadding
        intrinsicSuperViewContentSize.width += leftPadding + rightPadding
        return intrinsicSuperViewContentSize
        
    }

}
