//
//  BaseListDelegate.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BaseListDelegate: class {
    
    @objc optional func didChangeModelAtIndex(_ index: IndexPath, withRowAnimation animation: UITableView.RowAnimation)
//
//    @objc optional func didChangeLoadingState(_ state: LoadingState, completion: (()->())?)
    
    @objc optional func didChangeModelHeightAtIndex(_ index: IndexPath)
    
    @objc optional func didSelectModelAtIndex(_ index: IndexPath)
    
    @objc optional func didRemoveModelAtIndex(_ index: IndexPath)
    
    @objc optional func didChangeModels()
    
    @objc optional func moveToNext(_ index: IndexPath)
    
    @objc optional func scrollToIndexPath(_ index: IndexPath)
    
    @objc optional func endEditing()
    
    @objc optional func didChangeModelAtIndices(_ indices: [IndexPath])
    
    @objc optional func didChangeValues()
    
}
