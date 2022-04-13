//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Роман on 23.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class PostCordinator: Coordinator {    
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postVC = PostViewController()
        postVC.post = Post(title: "Post".localized())
        
        postVC.postVCCompletion = { [weak self] in
            guard let self = self else { return }
            let infoCoordinator = InfoCoordinator(navigationController: self.navigationController)
            self.childCoordinators.append(infoCoordinator)
            infoCoordinator.start()
        }
        navigationController.pushViewController(postVC, animated: true)
    }
}
