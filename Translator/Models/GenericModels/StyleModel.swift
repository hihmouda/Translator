//
//  StyleModel.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class StyleModel {
    
    var textcolor:SystemColors?
    
    var colorOpicity:CGFloat?
    
    var font:UIDeviceFonts?
    
    var textSize:CGFloat?
    
    var subfont:UIDeviceFonts?
    
    var subTextSize:CGFloat?
    
    var subTextcolor:SystemColors?
    
    var subColorOpicity:CGFloat?
    
    var backgroundColor:SystemColors?
    
    var backgroundOpicity:CGFloat?
    
    var leading: CGFloat?
    
    var trailing: CGFloat?
    
    var icon: SystemIcons?
    
    var iconColor: SystemColors?
    
    var textAlignment: NSTextAlignment?
    
    var separatorInset: UIEdgeInsets?
    
    var borderWidth: CGFloat?
    
    var borderColor: SystemColors?
    
    var cornerRadius: CGFloat?
    
    var numberOfLines: Int?
    
    var lineSpacing: CGFloat?
    
    var withShadow: Bool?
    
    var addingGradient: Bool?
    
    init(textcolor:SystemColors? = nil, colorOpicity:CGFloat? = 1.0,font:UIDeviceFonts? = nil, textSize:CGFloat? = nil,subfont:UIDeviceFonts? = nil, subTextSize:CGFloat? = nil,subTextcolor:SystemColors? = nil,subColorOpicity:CGFloat? = 1.0, backgroundColor:SystemColors? = nil, backgroundOpicity:CGFloat? = 1.0, leading:CGFloat? = nil, trailing:CGFloat? = nil, icon: SystemIcons? = nil, iconColor: SystemColors? = nil, textAlignment: NSTextAlignment? = nil, separatorInset: UIEdgeInsets? = nil,borderWidth:CGFloat?=nil, borderColor: SystemColors? = nil,cornerRadius:CGFloat? = nil, numberOfLines:Int? = nil, lineSpacing: CGFloat? = nil, withShadow:Bool? = false,addingGradient:Bool? = nil){
        
        
        self.textcolor = textcolor
        
        self.colorOpicity = colorOpicity
        
        self.font = font
        
        self.textSize = textSize
        
        self.backgroundColor = backgroundColor
        
        self.backgroundOpicity = backgroundOpicity
        
        self.subfont = subfont
        
        self.subTextSize = subTextSize
        
        self.subTextcolor = subTextcolor
        
        self.subColorOpicity = subColorOpicity
        
        self.leading = leading
        
        self.trailing = trailing
        
        self.icon = icon
        
        self.iconColor = iconColor
        
        self.textAlignment = textAlignment
        
        self.separatorInset = separatorInset
        
        self.borderWidth = borderWidth
        
        self.borderColor = borderColor
        
        self.cornerRadius  = cornerRadius
        
        self.numberOfLines = numberOfLines
        
        self.lineSpacing = lineSpacing
        
        self.withShadow = withShadow
        
        self.addingGradient = addingGradient
        
    }
    
}
