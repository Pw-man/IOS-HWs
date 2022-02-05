//
//  FeedViewControllerModel.swift
//  Navigation
//  Created by Роман on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

enum ConfigType {
    case first
    case second
}

protocol ViewOutput {
    var configuration: ConfigType? { get }
    var onSelectAction: (() -> Void)? { get }
}

protocol ViewInput {
    var onDidDissapear: (() -> Void)? { get set }
    var coordinator: Coordinator? { get set }
    var onDataChanged: ((String) -> Void)? { get set }
}

class FeedViewControllerViewModel: ViewInput & ViewOutput {

    var configuration: ConfigType? {
        if boolFlagForModelLogicExecution {
            return .first
        } else {
            return .second
        }
    }
    
    var model: FeedViewControllerModel
    var boolFlagForModelLogicExecution = false
    
    weak var coordinator: Coordinator?
    
    var onDidDissapear: (() -> Void)?
        
    var onDataChanged: ((String) -> Void)?
            
    var onSelectAction: (() -> Void)?

    init(model: FeedViewControllerModel) {
        self.model = model
    
        onDataChanged = { [weak self] text in
            guard let self = self else { return }
            if self.model.check(word: text) {
                self.boolFlagForModelLogicExecution = true
            } else {
                self.boolFlagForModelLogicExecution = false
            }
        }
    }
}
