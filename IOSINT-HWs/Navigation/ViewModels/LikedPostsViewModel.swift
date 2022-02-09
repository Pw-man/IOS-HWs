//
//  LikedPostsViewModel.swift
//  Navigation
//
//  Created by Роман on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class LikedPostsViewModel: ViewInput & ViewOutput {
    
    var onDidDissapear: (() -> Void)?
    
    var coordinator: Coordinator?
    
    var onDataChanged: ((String) -> Void)?
    
    var configuration: ConfigType?
    
    var onSelectAction: (() -> Void)?
    
    var model: LikedPostsModel
    
    init(model: LikedPostsModel) {
        self.model = model
    }    
}
