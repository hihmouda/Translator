//
//  MainView.swift
//  Translator
//
//  Created by hadeel on 12/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class MainView: BaseUIView {
    
    var button: UIButton = {
        var button = UIButton()
        button.setImage(IconsUtil.imageFor(.TRANSLATE_ICON), for: .normal)
        return button
    }()
    
   private var segment: UISegmentedControl = {
       
        let segmentedControl = UISegmentedControl(items: ["", "", ""])
        segmentedControl.tintColor = ColorUtil.getSystemColor(SystemColors.liteBlue)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : FontUtil.getFontWithSize(15, name: .medium), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : FontUtil.getFontWithSize(15, name: .medium), NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        // segment control style
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.clipsToBounds = true
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor =  ColorUtil.getSystemColor(SystemColors.liteBlue).cgColor
        segmentedControl.backgroundColor = ColorUtil.getSystemColor(SystemColors.liteBlue)
        return segmentedControl
    }()
    
    var tableView: UITableView = {
       
        var tableView = UITableView()
        // table view style
        tableView.backgroundColor = ColorUtil.getSystemColor(.accentBlue)
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        tableView.register(TranslatorTextTableViewCell.classForCoder(), forCellReuseIdentifier: "translatorTextTableViewCell")
        tableView.register(UserTextTableViewCell.classForCoder(), forCellReuseIdentifier: "userTextTableViewCell")
        return tableView
    }()
    
    var controlView: InputView = {
     
        return InputView()
    }()
    
    override func initializeView() {
        
        self.backgroundColor = ColorUtil.getSystemColor(.accentBlue)
       
        segment.setTitle("English", forSegmentAt: 0)
        segment.setTitle("Arabic", forSegmentAt: 2)
    }
    
    override func buildViewHierarchy() {
        super.buildViewHierarchy()
        
        self.addSubview(segment)
        self.addSubview(button)
        self.addSubview(tableView)
        self.addSubview(controlView)
    }
    
    override func setupConstraints() {
        
        self.segment.snp.makeConstraints { (make) in
            
            make.top.equalTo(self)
            make.trailing.equalTo(self).offset(-16)
            make.leading.equalTo(self).offset(16)
            make.height.equalTo(56)
        }
        
        self.button.snp.makeConstraints { (make) in
            
            make.center.equalTo(self.segment.snp.center)
            make.height.equalTo(56)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.segment.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.controlView.snp.top)
        }
        
        self.controlView.snp.makeConstraints { (make) in
            
            make.height.equalTo(150)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
}
