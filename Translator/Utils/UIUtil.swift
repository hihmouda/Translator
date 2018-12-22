//
//  UIUtil.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

let screenSize: CGSize = UIUtil.calculateScreenSize()

class UIUtil: NSObject {
    
    class func currentViewController() -> UIViewController? {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        if topController != nil {
            
            while topController?.presentedViewController != nil {
                
                topController = topController?.presentedViewController
            }
        }
        
        return topController
    }
    
    
    class func currentNavController() -> UINavigationController? {
        
        return UIUtil.currentViewController() as? UINavigationController ?? UIUtil.currentViewController()?.navigationController ?? UIUtil.getMainNavigationController()
    }
    
    class func getMainNavigationController() -> UINavigationController? {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        return appDelegate?.mainNavigationViewController
    }
    
    class func setMainNavigationController(_ navigationController:UINavigationController?){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        appDelegate?.mainNavigationViewController = navigationController
    }
    
    // Calculate the size of the screen
    class func calculateScreenSize() -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        let height = UIScreen.main.bounds.height
        
        if orientationIsLandscape() {
            
            return CGSize(width: height, height: width)
            
        } else {
            
            return CGSize(width: width, height: height)
            
        }
    }
    
    // Whether the UI is in landscape mode
    class fileprivate func orientationIsLandscape() -> Bool {
        return  UIApplication.shared.statusBarOrientation.isLandscape
    }
    
    class func getDeviceOrientation() -> UIInterfaceOrientation {
        
        return UIApplication.shared.statusBarOrientation
    }
    
    class func wasPushed(_ controller: UIViewController) -> Bool {
        
        if let viewControllers = controller.navigationController?.viewControllers {
            
            if viewControllers.count > 1 && viewControllers[viewControllers.count-1] == controller {
                
                // View controller was pushed onto the stack
                return true
            }
        }
        
        return false
    }
    
}
