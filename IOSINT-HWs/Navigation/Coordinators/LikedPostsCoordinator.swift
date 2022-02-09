//
//  LikedPostsCoordinator.swift
//  Navigation
//
//  Created by Роман on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class LikedPostsCoordinator: Coordinator & LikedPostsModuleFactory {
    
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: MainCoordinator?
    
    var navigationController: UINavigationController
        
    func makeLikePostsVC() -> LikedPostsViewController {
     return LikedPostsViewController(viewModel: LikedPostsViewModel(model: LikedPostsModel()))
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let likePostsVC = makeLikePostsVC()
        likePostsVC.viewModel.coordinator = self
        likePostsVC.viewModel.onDidDissapear = { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.childDidFinish(self)
        }
        likePostsVC.navigationItem.title = "Liked Posts"
        navigationController.tabBarItem.title = "Liked"
        navigationController.tabBarItem.image = UIImage(systemName: "heart")!
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(likePostsVC, animated: false)
    }
}
