//
//  TranslatorResponseModel.swift
//  Translator
//
//  Created by hadeel on 12/11/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import ObjectMapper

class TranslatorResponseModel: Mappable {

    var text: [String]?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        text   <- map["text"]
    }
}
