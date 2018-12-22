//
//  UserTextTableViewCell.swift
//  Translator
//
//  Created by hadeel on 12/6/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class UserTextTableViewCell: BasicCardCell {
    
    private var view: UIView = {
        
       let view = UIView()
        view.backgroundColor = ColorUtil.getSystemColor(.liteBlue)
        view.layer.borderColor =  ColorUtil.getSystemColor(.liteBlue).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private var label: UILabel = {
    
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 30
        label.font = FontUtil.getFontWithSize(15, name: .medium)
        return label
    }()
    
    override func buildViewHierarchy() {
        super.buildViewHierarchy()
        
        self.addSubview(view)
        self.view.addSubview(label)
    }
    
    override func initializeCellView() {
        
        self.backgroundColor = ColorUtil.getSystemColor(.accentBlue)
        
    }
    
    override func initializeView() {
        super.initializeView()
      
        DispatchQueue.main.async {
            
            self.view.roundCorners([.topLeft, .topRight, .bottomRight], radius: 20)
        }
        
        let text = model?.model as? String
        label.text = text
    }
    
    override func setupConstraints() {
        
        self.view.snp.makeConstraints { (make) in
            
            make.top.equalTo(self).offset(5)
            make.leading.equalTo(self).offset(22)
            make.trailing.equalTo(self).offset(-22)
            make.bottom.equalTo(self).offset(-5)

        }
        self.label.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.view).offset(5)
            make.leading.equalTo(self.view).offset(16)
            make.trailing.equalTo(self.view).offset(-16)
            make.bottom.equalTo(self.view).offset(-5)
        }
    }
}
