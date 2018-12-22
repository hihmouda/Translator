//
//  BaseUIView.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class BaseUIView: UIView {
    
    init() {
        
        super.init(frame: CGRect.zero)
        
        build()
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        build()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        build()
        
    }
    
    fileprivate func build() {
        
        initializeView()
        
        buildViewHierarchy()
        
        setupConstraints()
        
    }
    
    /// override this function to customize the look and feel for self
    func initializeView() {
        self.clipsToBounds = true
    }
    
    /// override this function to add subviews to their super viewes
    func buildViewHierarchy() {
        
    }
    
    // override this function to setup constraints for subviews
    func setupConstraints() {
        
    }
    
}

