//
//  ColorUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class ColorUtil: NSObject {
    
    /*
     Return system's predfind colors
     */
    class func getSystemColor(_ color : SystemColors, withOpicity opicity : CGFloat = 1.0) -> UIColor {
        
        return UIColor(hexString: color.rawValue, opicity: opicity)
    }
    
    /**
     calculates the color RGB number
     returns the color / 255.0 (RGB color base value)
     
     */
    class func RGBColorToRatio(_ RGB : CGFloat) -> CGFloat {
        
        return RGB / 255.0
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, opicity: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opicity)
    }
    
    convenience init(hexString: String, opicity: CGFloat = 1.0) {
        
        let hex = Int(hexString, radix: 16) ?? 0
        
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            opicity: opicity
        )
    }
    
}

