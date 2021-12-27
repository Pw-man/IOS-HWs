//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Роман on 22.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LogInViewController()
        loginVC.navigationItem.title = "Login"
        loginVC.loginCoordinator = self
        navigationController.tabBarItem.title = "Login"
        navigationController.tabBarItem.image = UIImage(systemName: "person")!
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(loginVC, animated: false)
    }
}