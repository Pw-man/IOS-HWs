//
//  FeedViewControllerModel.swift
//  Navigation
//
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
    var coordinator: Coordinator? { get set }
    var onDataChanged: ((String) -> Void)? { get set }
}

class FeedViewControllerViewModel: ViewInput & ViewOutput {

    var configuration: ConfigType? {
        if modelLogic {
            return .first
        } else {
            return .second
        }
    }
    
    var model: FeedViewControllerModel
    var modelLogic = false
    
    weak var coordinator: Coordinator?
        
    var onDataChanged: ((String) -> Void)?
            
    var onSelectAction: (() -> Void)? {
        return {
            self.onDataChanged = { [weak self] text in
                guard let self = self else { return }
                if self.model.check(word: text) {
                    self.modelLogic = true
                } else {
                    self.modelLogic = false
                }
            }
        }
    }

    init(model: FeedViewControllerModel) {
        self.model = model
        
        onSelectAction?()
    }
}
