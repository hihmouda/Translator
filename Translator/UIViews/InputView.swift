//
//  InputView.swift
//  Translator
//
//  Created by hadeel on 12/4/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class InputView: BaseUIView {
 
    private var line: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var textField: UITextField = {
        
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSMutableAttributedString.init(string: "Write your text", attributes: [NSAttributedString.Key.font : FontUtil.getFontWithSize(15, name: .medium), NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.accessibilityIdentifier = "TEXT_FIELD"
        return textField
    }()
    
    var sendButton: UIButton = {
        
        var button = UIButton()
        button.setImage(IconsUtil.imageFor(.SEND), for: .normal)
        button.accessibilityIdentifier = "BUTTON_SUBMISSION"
        return button
    }()
    
    var micButton: UIButton = {
        
        var button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.borderColor = ColorUtil.getSystemColor(.red).cgColor
        button.layer.borderWidth = 1
        button.applyGradient(colours: [ColorUtil.getSystemColor(.red), ColorUtil.getSystemColor(.yellow)])
        let imageView = UIImageView(frame: CGRect.init(x: 15, y: 10, width: 20, height: 30))
        imageView.image = IconsUtil.imageFor(.RECORDER)
        button.addSubview(imageView)
        button.clipsToBounds = true
        button.accessibilityIdentifier = "MIC_BUTTON"
        return button
    }()
    
    var imageButton: UIButton = {
        
        var button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.borderColor = ColorUtil.getSystemColor(.red).cgColor
        button.layer.borderWidth = 1
        button.applyGradient(colours: [ColorUtil.getSystemColor(.red), ColorUtil.getSystemColor(.yellow)])
        let imageView = UIImageView(frame: CGRect.init(x: 5, y: 10, width: 40, height: 30))
        imageView.image = IconsUtil.imageFor(.IMAGE)
        button.addSubview(imageView)
        button.clipsToBounds = true
        button.accessibilityIdentifier = "IMAGE_BUTTON"
        return button
    }()

    override func buildViewHierarchy() {
        
        self.addSubview(line)
        self.addSubview(textField)
        self.addSubview(sendButton)
        self.addSubview(micButton)
        self.addSubview(imageButton)
    }
    
    override func setupConstraints() {
        
        line.snp.makeConstraints { (make) in
            
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(2)
        }
        
        textField.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.line.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(22)
            make.trailing.equalTo(self.sendButton.snp.leading).offset(-2)
        }
        
        sendButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.line.snp.bottom).offset(-10)
            make.leading.equalTo(self.textField.snp.trailing).offset(2)
            make.trailing.equalTo(self).offset(-16)
            make.height.width.equalTo(70)
        }
        
        micButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(100)
            make.bottom.equalTo(-40)
            make.height.width.equalTo(50)
        }
        
        imageButton.snp.makeConstraints { (make) in
           
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-100)
            make.bottom.equalTo(-40)
            make.height.width.equalTo(50)
        }
    }
}

extension UIView {
    
    func applyGradient(colours: [UIColor], frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)) -> Void {
        
        self.applyGradient(colours: colours, locations: nil, frame: frame)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)) -> Void {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = frame
        self.layer.addSublayer(gradient)
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
