//
//  BaseCardModelDelegate.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation

protocol BaseCardModelDelegate: class {
    
    func didChangeModel(_ model: BaseCardModel?)
    
    func didRemoveModel(_ model: BaseCardModel?)
    
    func moveToNext(_ modelIndex: IndexPath)
}
