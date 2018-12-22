//
//  RequestUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation

// request default static values
struct RequestDefaultValues {
    
    static let HTTPS_PART                                 = "https://"
    static let API_PATH                                   = "translate.yandex.net/api/v1.5/"
}

//Add system service URL static path strings
struct SystemServiceUrls {
    
    // translate text
    static let TRANSLATE_TEXT                = "tr.json/translate?key=\(AppDefaults.apiKey)&text=%@&lang=%@"
}

class RequestUtil: NSObject {
    
    /**
     Class function to return system service url strings
     */
    class func getServiceUrlString(_ service : SystemService, para: [String]) -> String {
        
        //get system base url
        var baseSystemUrlString = getSystemBaseURL()
        
        //switch on services enum value
        switch service {
            
        case .translateText:
            
            baseSystemUrlString = "\(baseSystemUrlString)\(String(format: SystemServiceUrls.TRANSLATE_TEXT, arguments: para))"
            
            break
        }
     
        return baseSystemUrlString
    }
    
    /**
     System Base url, return the service apis base url
     */
    fileprivate class func getSystemBaseURL() -> String {

        return RequestDefaultValues.HTTPS_PART + RequestDefaultValues.API_PATH

    }
}
