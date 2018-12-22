//
//  BaseUITableViewCell.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class BaseUITableViewCell: UITableViewCell {
    
    init() {
        
        super.init(style: .default, reuseIdentifier: nil)
        
        build()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        build()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        build()
        
    }
    
    func build() {
        
        initializeCellView()
        
        buildViewHierarchy()
        
        setupConstraints()
    }
    
    /// override this function to customize the look and feel for self
    func initializeCellView() {
        
        self.clipsToBounds = true
    }
    
    /// override this function to add subviews to their super viewes
    func buildViewHierarchy() {
        
    }
    
    // override this function to setup constraints for subviews
    func setupConstraints() {
        
    }
    
}
