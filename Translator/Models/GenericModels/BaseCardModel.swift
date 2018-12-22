//
//  BaseCardModel.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class BaseCardModel {
    
    var modelId: String?
    
    var modelType: ModelType?
    
    var model: Any?
    
    var onSelectAction : (() -> ())?
    
    var executeActionOnDidSelect : Bool = true
    
    var height: CGFloat = 60
    
    var collapsed: Bool = false
    
    var style:StyleModel?
    
    func calculcateHeight() -> CGFloat {
        
        return collapsed ? 0 : height
    }
}



