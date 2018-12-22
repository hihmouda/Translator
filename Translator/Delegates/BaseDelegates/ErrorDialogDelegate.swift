//
//  ErrorDialogDelegate.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation

@objc protocol ErrorDialogDelegate: class {
    
    @objc optional func dialogDidShown()
    
    @objc optional func didDismiss()
}
