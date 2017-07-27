//
//  Utilities.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 27/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import UIKit

// MARK: DateUtils

private let dateFormat = "dd/MM/yyyy"
private let timeFormat = "HH:mm"
private let dayFormat  = "dd, MMM"

func dateFormatter() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
    
}

func timeFormatter() -> DateFormatter {
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = timeFormat
    
    return timeFormatter
    
}

func dayFormatter() -> DateFormatter {
    
    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = dayFormat
    
    return dayFormatter
    
}

// MARK: ImageUtils

func imageFromData(imageData: String, withBlock: (_ image: UIImage?) -> Void){
 
    var image: UIImage?
    
    let decodedData = NSData(base64Encoded: imageData, options:     NSData.Base64DecodingOptions(rawValue: 0))

    image = UIImage(data: decodedData! as Data)
    
    withBlock(image)
    
}

