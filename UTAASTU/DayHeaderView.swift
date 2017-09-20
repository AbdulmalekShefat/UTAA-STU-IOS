//
//  DayHeaderView.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 05/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import UIKit

class DayHeaderView: UIPaddingLabel {
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var view: UIPaddingLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        container = loadViewFromNib()
        container.frame = bounds
        
        container.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        
        container.sizeToFit()
        
        addSubview(container)
        
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setTitle(title: String){
        view.text = title
    }
    
    func setColor(color: UIColor){
        view.textColor = color
    }
    
}
