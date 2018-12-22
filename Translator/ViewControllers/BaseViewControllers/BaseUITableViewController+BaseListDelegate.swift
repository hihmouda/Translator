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
    
//    func moveToNext(_ index: IndexPath) {
//
//        var nextIndex = IndexPath(item: index.row+1, section: index.section)
//
//        // get number for rows in given index section
//        let numOfRows = self.effectiveTableView?.numberOfRows(inSection: index.section) ?? 0
//
//        // if given row is the last in the given section, move to next section
//        if index.row >= numOfRows - 1 {
//
//            nextIndex = IndexPath(item: 0, section: index.section+1)
//        }
//
//        // Scroll to index so that it's visible, then get textField focus
//        if !isVisible(nextIndex) {
//
//            self.effectiveTableView?.scrollToRow(at: index, at: .top, animated: true)
//        }
//
//        if let nextCell = self.effectiveTableView?.cellForRow(at: nextIndex){
//
//            if let nextTextCell = nextCell  as? SimpleTextFieldCell {
//
//                let _ = nextTextCell.becomeFirstResponder()
//            } else {
//
//                moveToNext(nextIndex)
//            }
//        }
//    }
    
    func endEditing() {
        
        self.view.endEditing(true)
    }
}
