//
//  tabBarController.swift
//  Navigation
//
//  Created by Роман on 13.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator.start()
        viewControllers = [mainCoordinator.feedCoordinator.navigationController, mainCoordinator.loginCoordinator.navigationController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}
