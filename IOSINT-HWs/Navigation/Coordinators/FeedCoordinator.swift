//
//  File.swift
//  Navigation
//
//  Created by Роман on 22.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FeedCoordinator: Coordinator {
        
    weak var parentCoordinator: MainCoordinator?
    
    let feedVCFactory = MyFeedViewControllerFactory()
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myFeedModuleFactory = myFeedModelFactory()
        let feedModule = myFeedModuleFactory.makeModule()
        feedModule.viewController.viewModel.onDataChanged = {
            print("228")
        }
        let feedVC = feedVCFactory.makeFeedViewContoller()
        feedVC.navigationItem.title = "Feed"
        
        feedVC.feedVCCompletion = { [weak self] in
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
    
    func feedVCDidClose() {
        parentCoordinator?.childDidFinish(self)
    }
}
