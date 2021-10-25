//
//  FeedViewControllerModel.swift
//  Navigation
//
//  Created by Роман on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol ViewOutput {
    
    var buttonTapped: (() -> Void)? { get }
}

protocol ViewInput {
    
    var onDataChanged: (() -> Void)? { get set }
}

class FeedViewControllerViewModel: ViewOutput & ViewInput {
    
    var model: FeedViewControllerModel
    
    init(model: FeedViewControllerModel) {
        self.model = model
    }
    
    var onDataChanged: (() -> Void)? 
            
    var buttonTapped: (() -> Void)? {
        return {
            self.onDataChanged?()
        }
    }
}
