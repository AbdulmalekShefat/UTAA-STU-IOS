//
//  colorsView.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 05/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import UIKit

class ColorsView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var childe: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        view.sizeToFit()
        
        addSubview(view)
        
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
}
