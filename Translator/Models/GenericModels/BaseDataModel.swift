//
//  BaseDataModel.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation
import UIKit

class BaseDataModel: BaseCardModelDelegate {
    
    var models : [BaseCardModel] = []
    
    weak var listDelegate: BaseListDelegate?
    
    init() {}
    
    func appendModel(_ modelType : ModelType, modelId: String? = nil, modelData : Any? = nil, initialHeight: CGFloat = 60, style:StyleModel? = nil, collapsed: Bool = false, executeActionOnDidSelect: Bool = true, onSelectModel: (() -> ())? = nil) {
        
        let model = BaseCardModel()

        model.modelType = modelType
        
        model.modelId = modelId
        
        model.model = modelData
        
        model.height = initialHeight
        
        model.onSelectAction = onSelectModel
        
        model.style = style
        
        model.collapsed = collapsed
        
        model.executeActionOnDidSelect = executeActionOnDidSelect
        
        models.append(model)
        
    }
    
    func getModelIndex(_ modelType : ModelType) -> Int? {
        
        for (index,model) in models.enumerated() {
            
            if model.modelType == modelType {
                
                return index
            }
        }
        
        //in case its not found
        return nil
    }
    
    func getModels(_ modelType : ModelType) -> [(found: BaseCardModel, index: Int)] {
        
        var modelsForType: [(found: BaseCardModel, index: Int)] = []
        
        for (i, model) in models.enumerated() {
            
            if model.modelType == modelType {
                
                modelsForType.append((model, i))
            }
        }
        
        return modelsForType
    }
    
    func getModelWithId(_ modelId: String) -> (found: BaseCardModel, index: Int)? {
        
        for (index,model) in models.enumerated() {
            
            if model.modelId == modelId {
                
                return (model, index)
            }
        }
        
        //in case its not found
        return nil
    }
    
    func clear() {
        
        self.models.removeAll()
    }
    
    func didChangeModel(_ model: BaseCardModel?) {
        
        // Default implementation, you can orverride in super
        
        guard let modelId = model?.modelId, let index = getModelWithId(modelId)?.index else { return }
        
        listDelegate?.didChangeModelAtIndex?(IndexPath(row: index, section: 0), withRowAnimation: .automatic)
    }
    
    func didRemoveModel(_ model :BaseCardModel?){
        
        // Default implementation, you can override in super when neccessary
        guard let modelId = model?.modelId, let index = getModelWithId(modelId)?.index else { return }
        
        self.listDelegate?.didRemoveModelAtIndex?(IndexPath(item: index, section: 0))
    }
    
    func moveToNext(_ modelIndex: IndexPath) {
        
        // Default implementation
        self.listDelegate?.moveToNext?(modelIndex)
    }
}
