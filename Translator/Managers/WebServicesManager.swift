//
//  WebServicesManager.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class WebServicesManager {
    
    /*
     Translate text
     */
    class func translateText(text: String, target: String, completeHandler: @escaping (_ isSuccess: Bool, _ result : TranslatorResponseModel?) -> ()) {
        
        let requestString = RequestUtil.getServiceUrlString(.translateText, para: [text, target])
        
        Loader.loadContentOfUrl(requestString, requestType: .POST, bodyType: .JSON, isAuthenticated: false, completeHandler: { (isSuccess, response) -> () in
            
            var responseStr = ""
            
            if let response = response {
                
                responseStr = String(data:response, encoding:String.Encoding.utf8) ?? ""
                
                print("the response string is  \(responseStr)")
            }
            
            completeHandler(isSuccess, Mapper<TranslatorResponseModel>().map(JSONString: responseStr))
        })
    }
}

extension String {

    func toData() -> Data? {
        
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)
    }
}
