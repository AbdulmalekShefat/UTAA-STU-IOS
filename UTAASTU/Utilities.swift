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

extension UIImage {
    
    var isPortrait:     Bool    {return size.height > size.width}
    var isLandscape:     Bool    {return size.width > size.height}
    var breadth:        CGFloat {return min(size.width, size.height)}
    var breadthSize:    CGSize  {return CGSize(width: breadth, height: breadth)}
    var breadthRect:    CGRect  {return CGRect(origin: .zero, size: breadthSize)}
    var circleMask:     UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height)/2) : 0, y: isPortrait ? floor((size.height - size.width)/2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    
    }
    
    func scaleImagetoSize(newSize: CGSize) -> UIImage {
        
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width / size.width
        let aspectHeight = newSize.height / size.height
        
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
        
    }
    
}








