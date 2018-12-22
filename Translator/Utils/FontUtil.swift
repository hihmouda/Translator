//
//  FontUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class FontManager {
    
    // initializes concurrentQueue as a concurrent queue
    fileprivate let concurrentQueue = DispatchQueue(
        label: "yamsafer.FontManager.concurrentQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    private var _fontDict: [String:UIFont]  = [:]
    
    var fontDict: [String:UIFont] {
        var fontDictCopy: [String:UIFont] = [:]
        concurrentQueue.sync {
            fontDictCopy = self._fontDict
        }
        return fontDictCopy
    }
    
    static let sharedInstance =  FontManager()
    
    func addFont(key: String, font: UIFont){
        
        concurrentQueue.async(flags: .barrier) {
            
            self._fontDict.update(key, value: font)
            
        }
    }
    
    private init() {
        
    }
}

class FontUtil {
    
    /**
     Get font from device defaults with specific size and color
     */
    class func getFontWithSize(_ size : CGFloat , name : UIDeviceFonts) -> UIFont {
        
        var size = size
        
        let key = size.description + name.rawValue
        
        if let font = FontManager.sharedInstance.fontDict[key] {
            
            return font
        }
        
        let font = UIFont(name: getFontName(name) , size: size) ?? UIFont()
        
        FontManager.sharedInstance.addFont(key: key, font: font)
        
        return font
    }
    
    /**
     Get font name from font type
     */
    fileprivate class func getFontName(_ type : UIDeviceFonts) -> String {
        
        return getEnglishFont(type)
    }
    
    class fileprivate func getEnglishFont(_ type: UIDeviceFonts) -> String {
       
        switch type {

        case .medium:
            return "Avenir-Medium"
        }
        
        return ""
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value:Any {
    
    /**
     *  add a non null value to the dictionary
     */
    mutating func update(_ key: Key, value : Value?){
        
        if let value = value {
            
            self[key] = value
        }
    }
    
    func toData() -> Data? {
        
        let data = (try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted))
        
        return  data
        
    }
}
