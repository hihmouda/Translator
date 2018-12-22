//
//  MainViewController.swift
//  Translator
//
//  Created by hadeel on 12/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: BaseUITableViewController{
    
    private var mainView: MainView? {
        
        return self.view as? MainView
    }
    
    override func loadView() {
        
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        
        self.listModel = BaseDataModel()
   
        self.effectiveTableView = self.mainView?.tableView
        
        self.mainView?.tableView.delegate = self
        
        self.mainView?.tableView.dataSource = self
     
        super.viewDidLoad()
    
        self.mainView?.controlView.sendButton.addTarget(self, action: #selector(translateText), for: .touchUpInside)
    }
    
    override func normalNavBar() {
      
        self.initNavigationBar(withBackIcon: nil, andTitle: "Translator", color: ColorUtil.getSystemColor(.accentBlue), textColor: .white)
    
    }
    
    @objc private func translateText(){
        
        if let text = self.mainView?.controlView.textField.text, !text.isEmpty {
         
            let height = StringUtil.getStringSize(text, width: screenSize.width - 40, forFont: FontUtil.getFontWithSize(15, name: .medium)).height
            
            self.listModel?.appendModel(.userTextCell, modelId: "USER_TEXT", modelData: text, initialHeight: height < 80 ? 80 : height)
            
            self.didChangeModels()
            
            WebServicesManager.translateText(text: text, target: "ar") { (success, translatorResponseModel) in
               
                if success, let translatorText = translatorResponseModel?.text?.first {
                 
                    let height = StringUtil.getStringSize(translatorText, width: screenSize.width - 40, forFont: FontUtil.getFontWithSize(15, name: .medium)).height
                    
                    self.listModel?.appendModel(.translatorTextCell, modelId: "TRANSLATOR_TEXT", modelData: translatorText, initialHeight: height < 80 ? 80 : height)
                    
                    DispatchQueue.main.async {

                        self.didChangeModels()

                        self.scrollToIndexPath(IndexPath.init(row: ((self.listModel?.models.count ?? 1) - 1), section: 0))

                    }
                    
                }
            }
            
            self.mainView?.controlView.textField.text = ""
        }
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let baseCardModel = self.listModel?.models[safe: indexPath.row] else { return 0 }
        
        let height = baseCardModel.calculcateHeight()
        
        return height > 0 ? height : 0
    }
}


class StringUtil {
    
    // calculate the size needed for a string in a frame
    class func getStringSize(_ string : String? = nil, attributedText: NSAttributedString? = nil , width: CGFloat, forFont font : UIFont? = nil) -> CGSize
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width , height: CGFloat.greatestFiniteMagnitude))
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.numberOfLines = 0
        
        if let string = string {
            
            label.text = string
            
        } else if let attributedText = attributedText {
            
            label.attributedText = attributedText
        }
        
        if let textFont = font {
            
            label.font = textFont
        }
        
        label.sizeToFit()
        
        return CGSize(width: label.frame.width, height: label.frame.height)
    }
}
