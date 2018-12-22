//
//  BaseUIViewController.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class BaseUIViewController: UIViewController {

    var animatedTransition: Bool = true

    func backAction(_ completion: (()->Void)? = nil) {
        
        if UIUtil.wasPushed(self) {
            
            let _ = self.navigationController?.popViewController(animated: animatedTransition)
            
        } else {
            
            self.dismiss(animated: animatedTransition, completion: completion)
        }
    }
    
    func rightAction() {
        
        // Empty implementation, override in sub as you wish
    }
    
    @objc fileprivate func backButtonClicked() {
        
        backAction()
    }
    
    @objc fileprivate func rightButtonClicked() {
        
        rightAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.normalNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func normalNavBar() {
        // Empty implementation
    }
    
    func initNavigationBar(withBackIcon leftIcon:SystemIcons? = nil, andTitle: String? = nil, attributedTitle: NSAttributedString? = nil, rightIcon: SystemIcons? = nil, rightTitle: String? = nil, righTitleColor: UIColor? = nil, extended: Bool = false, color: UIColor? = nil, textColor: UIColor? = nil, barStyle: UIBarStyle? = .default, space: CGFloat? = nil, leftButtonIsEnabled: Bool? = nil, rightButtonIsEnabled: Bool? = nil) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        if #available(iOS 11.0, *) {
            
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
        
        if !extended {
            
            self.edgesForExtendedLayout = []
            self.extendedLayoutIncludesOpaqueBars = false
        } else {
            
            self.edgesForExtendedLayout = .top
            self.extendedLayoutIncludesOpaqueBars = true
        }
        
        self.initNavigationBar(leftIcon: leftIcon, title: andTitle, attributedTitle: attributedTitle, rightIcon: rightIcon, rightTitle: rightTitle, righTitleColor: righTitleColor, color: color, textColor: textColor, space: space)
        
        if let barStyle = barStyle {
            
            self.navigationController?.navigationBar.barStyle = barStyle
        }
        
        if let rightButtonIsEnabled = rightButtonIsEnabled {
            
            self.barButtonItem(enabled: rightButtonIsEnabled, barButtonItem: .rightBarButton)
        }
        
        if let leftButtonIsEnabled = leftButtonIsEnabled {
            
            self.barButtonItem(enabled: leftButtonIsEnabled, barButtonItem: .leftBarButton)
        }
    }
    
    private func barButtonItem(enabled: Bool, barButtonItem: BarButtonItem){
        
        let navigationBar = barButtonItem == .leftBarButton ? self.navigationItem.leftBarButtonItem : self.navigationItem.rightBarButtonItem
        
        navigationBar?.isEnabled = enabled
        
    }
    
    private func initNavigationBar(leftIcon:SystemIcons? = nil, title: String? = nil, attributedTitle: NSAttributedString? = nil, rightIcon: SystemIcons? = nil, rightTitle: String? = nil, righTitleColor: UIColor? = nil, color: UIColor? = nil, textColor: UIColor? = nil, space:CGFloat? = nil){
        
        self.setBackgroundColorOfNavigationBar(color: color)
        
        self.setNavigationBarTitle(title: title, attributeString: attributedTitle, textColor: textColor)
        
        if let leftIcon = leftIcon {
            
            self.setBarButtonItem(icon: leftIcon, space: space, barButtonItem: .leftBarButton)
            
        }
        
        if let rightIcon = rightIcon {
            
            self.setBarButtonItem(icon: rightIcon, space: space, barButtonItem: .rightBarButton)
            
        }
        
        if let rightIcon = rightIcon , let rightString = rightTitle {
            
            self.setBarButtonItem(icon: rightIcon, title: rightString, color: righTitleColor ?? ColorUtil.getSystemColor(.liteBlue), space: space, barButtonItem: .rightBarButton)
            
        } else if let rightString = rightTitle {
            
            self.setBarButtonItem(title: rightString, color: righTitleColor ?? ColorUtil.getSystemColor(.liteBlue), space: space, barButtonItem: .rightBarButton)
            
        }
        
    }
    
    private func setBackgroundColorOfNavigationBar(color: UIColor?){
        
        if let color = color {
            
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor = color
            
        } else {
            
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.clear
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        }
    }
    
    private func setNavigationBarTitle(title: String? = nil, attributeString: NSAttributedString? = nil, textColor: UIColor? = nil) {
        
        let label = UILabel()
        
        label.font = FontUtil.getFontWithSize(15, name: .medium)
        
        if let title = title {
            
            label.text = title
            
        }
        
        if let textColor = textColor {
            
            label.textColor = textColor
            
        } else {
            
            label.textColor = ColorUtil.getSystemColor(.liteBlue)
        }
        
        if let attributedTitle = attributeString {
            
            label.attributedText = attributedTitle
            
        }
        
        label.sizeToFit()
        
        label.textAlignment = .center
        
        label.frame = CGRect(x: 0, y: 0, width: screenSize.width - 150, height: 20)
        
        self.navigationItem.titleView = label
    }
    
    private func setBarButtonItem(icon: SystemIcons? = nil, title: String? = nil, color: UIColor = ColorUtil.getSystemColor(.liteBlue), space:CGFloat? = nil, barButtonItem: BarButtonItem){
        
        let button = UIBarButtonItem()
        
        let barButton = customButtonView(icon: icon, title: title, color: color)
        
        button.style = .plain
        
        button.customView = barButton
        
        if barButtonItem == .leftBarButton{
            
            barButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            
            self.navigationItem.leftBarButtonItem = button
            
        }else{
            
            barButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
            
            self.navigationItem.rightBarButtonItem = button
        }
        
        // adding inset to leftIcon
        if let space = space {
            
            let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            
            negativeSpacer.width = space
            
            if barButtonItem == .leftBarButton{
                self.navigationItem.setLeftBarButtonItems([negativeSpacer, button], animated: false)
            }else{
                self.navigationItem.setRightBarButtonItems([negativeSpacer, button], animated: false)
            }
        }
    }
    
    private func customButtonView(icon: SystemIcons? = nil, title: String? = nil, color: UIColor = ColorUtil.getSystemColor(.liteBlue)) -> CustomButtonWithTapArea{
        
        let barButton = CustomButtonWithTapArea()
        
        let textAttachment = NSTextAttachment()
        
        var iconWidth:CGFloat = 0.0
        
        if let icon = icon{
            
            let iconAttrs = IconsUtil.iconAttrs(icon)
            
            if let cgImage = IconsUtil.imageFor(icon)?.cgImage, let scale = IconsUtil.imageFor(icon)?.scale, iconAttrs.needsRTLFilp  {
                
                textAttachment.image = UIImage(cgImage: cgImage, scale: scale, orientation: .upMirrored)
                
            }else{
                
                textAttachment.image = IconsUtil.imageFor(icon)
                
            }
            
            iconWidth = textAttachment.image?.size.width ?? iconAttrs.width
            
            textAttachment.bounds = CGRect(x: 0, y: -4, width: iconWidth, height:(textAttachment.image?.size.height ?? iconAttrs.height))
        }
        
        let attributeString = NSMutableAttributedString.init(string: title ?? "", attributes: [NSAttributedString.Key.font: FontUtil.getFontWithSize(12, name: .medium), NSAttributedString.Key.foregroundColor: color])
        
        attributeString.append(NSAttributedString.init(attachment: textAttachment))
        
        barButton.frame = CGRect(x: 0, y: 0, width: (30), height: 20)
        
        barButton.setAttributedTitle(attributeString, for: .normal)
        
        barButton.isMultipleTouchEnabled = false
        
        return barButton
    }
}

class CustomButtonWithTapArea: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        return self.bounds.insetBy(dx: -30, dy: -10 ).contains(point)
    }
    
}
