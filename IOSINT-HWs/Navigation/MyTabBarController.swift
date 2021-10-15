//
//  tabBarController.swift
//  Navigation
//
//  Created by Роман on 13.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let myFeedViewControllerFactory = MyFeedViewControllerFactory()
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let feedViewController = myFeedViewControllerFactory.makeFeedViewContoller()
        let loginViewControler = LogInViewController()
        let viewControllers = [
            createNavController(for: feedViewController, title: "Feed", image: UIImage(systemName: "house")!),
            createNavController(for: loginViewControler, title: "Login", image: UIImage(systemName: "person")!)
        ]
        self.viewControllers = viewControllers
    }
}
