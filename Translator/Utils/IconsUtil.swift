//
//  IconsUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class IconsUtil: NSObject {
    
    class func iconAttrs(_ icon: SystemIcons) ->  (width: CGFloat, height: CGFloat, needsRTLFilp: Bool) {
        
        var attrs : (width: CGFloat, height: CGFloat, needsRTLFilp: Bool) = (20,20, false)
        
        switch icon {

        case .TRANSLATE_ICON:
            attrs = (33, 33, false)

        case .IMAGE:
            attrs = (41, 30, false)

        case .RECORDER:
            attrs = (20, 33, false)

        case .SEND:
            attrs = (30, 30, false)
        }
        
        return attrs
    }
    
    // returns an UIImageView with the icon embeded inside and constrains
    class func iconNamed(_ name: SystemIcons) -> UIImageView {
        
        let attrs = iconAttrs(name)
        
        return IconsUtil.iconNamed(name.rawValue, width: attrs.width, height: attrs.height, needsRTLFlip: attrs.needsRTLFilp)
    }
    
    // on return UIImage
    class func imageFor(_ name: SystemIcons) -> UIImage? {
        
        let attrs = iconAttrs(name)
        
        return imageFor(name.rawValue, needsRTLFlip: attrs.needsRTLFilp)
    }
    
    fileprivate class func iconNamed(_ name: String, width: CGFloat, height: CGFloat, needsRTLFlip: Bool) -> UIImageView {
        
        let icon = UIImageView()
        
        icon.image = imageFor(name, needsRTLFlip: needsRTLFlip)
        
        icon.snp.makeConstraints { make in
            
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        icon.contentMode = .scaleAspectFit
        
        return icon
    }
    
    fileprivate class func imageFor(_ name: String, needsRTLFlip: Bool) -> UIImage? {
        
        let image = UIImage(named: name)
        
        if needsRTLFlip {
            
            return image?.imageFlippedForRightToLeftLayoutDirection()
        }
        return image
    }
    
}
