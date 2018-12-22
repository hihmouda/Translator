//
//  BaseUITableViewController+BaseListDelegate.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

extension BaseUITableViewController: BaseListDelegate {
    
    func didChangeModelAtIndex(_ index: IndexPath, withRowAnimation animation: UITableView.RowAnimation) {
        
        // Default implementation, override as you wish
        
        self.effectiveTableView?.beginUpdates()
        
        self.effectiveTableView?.reloadRows(at: [index], with: animation)
        
        self.effectiveTableView?.endUpdates()
    }
    func didChangeModelAtIndices(_ indices: [IndexPath]) {
        
        self.effectiveTableView?.beginUpdates()
        
        self.effectiveTableView?.reloadRows(at: indices, with: .none)
        
        self.effectiveTableView?.endUpdates()
    }
    
    func didRemoveModelAtIndex(_ index: IndexPath){
        
        // Default implementation, override as you wish
        
        self.listModel?.models.remove(at: index.row)
        
        self.effectiveTableView?.beginUpdates()
        
        self.effectiveTableView?.deleteRows(at: [index], with: .automatic)
        
        self.effectiveTableView?.endUpdates()
    }
    
    func didChangeModelHeightAtIndex(_ index: IndexPath) {
        
        self.effectiveTableView?.beginUpdates()
        self.effectiveTableView?.endUpdates()
    }
    
    func didChangeModels() {
        
        self.effectiveTableView?.reloadData()
    }
    
    func scrollToIndexPath(_ index: IndexPath) {
        
        self.effectiveTableView?.scrollToRow(at: index, at: .top, animated: true)
    }
    
    func endEditing() {
        
        self.view.endEditing(true)
    }
}
