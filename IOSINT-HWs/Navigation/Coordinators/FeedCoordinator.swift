//
//  File.swift
//  Navigation
//
//  Created by Роман on 22.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FeedCoordinator: Coordinator & FeedModuleFactory {
        
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeVC() -> FeedViewController {
        return FeedViewController(viewModel: FeedViewControllerViewModel(model: FeedViewControllerModel()))
    }
    
    func start() {
        let feedVC = makeVC()
        feedVC.viewModel.coordinator = self
        
        feedVC.navigationItem.title = "Feed"
        
        feedVC.pushNextVC = { [weak self] in
            guard let self = self else { return }
            let postCoordinator = PostCordinator(navigationController: self.navigationController)
            postCoordinator.start()
            self.childCoordinators.append(postCoordinator)
        }
        
        navigationController.tabBarItem.title = "Feed"
        navigationController.tabBarItem.image = UIImage(systemName: "house")!
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(feedVC, animated: false)
    }
    
    func VCDidDissapear() {
        parentCoordinator?.childDidFinish(self)
    }
}
