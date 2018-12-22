//
//  UserDefaultUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

public struct UserDefaultsKeys {
    
    public static let UDID_KEY   = "UDID"
    
}

struct UserDefault {
    
    static var userDefaults : UserDefaults = UserDefaults.standard
    
}

class UserDefaultUtil: NSObject {

    class func removeValue(_ key:String?) {
        
        if let key = key {
            
            UserDefault.userDefaults.removeObject(forKey: key)
        }
    }
    
    // set string value to user defauls
    class func setStringValue(_ value : String?, forKey key : String?) {
        
        //check if value and key are not null
        if let value = value, let key = key {
            
            UserDefault.userDefaults.set(value, forKey: key)
            UserDefault.userDefaults.synchronize()
        }
    }
    
    //get string value from user default
    class func getStringValueForKey(_ key : String?) -> String? {
        
        if let key = key {
            
            //get value
            if let value = UserDefault.userDefaults.object(forKey: key) as? String {
                
                return value
            }
        }
        
        return nil
    }
    
    // set Object value to user defauls
    class func setObjectValue(_ value : Any?, forKey key : String?) {
        
        //check if value and key are not null
        if let value = value , let key = key {
            
            UserDefault.userDefaults.set(value, forKey: key)
            UserDefault.userDefaults.synchronize()
        }
    }
    
    //get object value from user default
    class func getObjectValueForKey(_ key : String?) -> Any? {
        
        //check if key is null
        guard let key = key else { return nil }
        
        //get value
        return UserDefault.userDefaults.object(forKey: key)
        
    }
    
    //get data value from user default
    class func getDataValueForKey(_ key : String?) -> Data? {
        
        
        if let key = key {
            
            //get value
            return UserDefault.userDefaults.data(forKey: key)
        }
        return nil
    }
    
    //get Integer value from user default
    class func getIntegerValueForKey(_ key : String?) -> Int? {
        
        //check if key is null
        guard let key = key else { return nil }
        
        //get value
        let value  = UserDefault.userDefaults.integer(forKey: key)
        
        return value
    }
    
    class func setIntegerValue(_ value : Int?,forKey key : String?) {
        
        if let value = value, let key = key{
            
            UserDefault.userDefaults.set(value, forKey: key)
        }
    }

}
