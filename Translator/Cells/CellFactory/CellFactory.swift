//
//  CellFactory.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class CellFactory {
    
    class func constructCell(_ model : BaseCardModel, tableView : UITableView, indexPath:IndexPath? = nil) -> BasicCardCell {
        
        if let modelType = model.modelType, let cell = tableView.dequeueReusableCell(withIdentifier: modelType.rawValue) as? BasicCardCell {
            
            cell.model = model
            
            cell.indexPath = indexPath
            
            cell.initializeView()
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        return BasicCardCell()
    }
    
}
