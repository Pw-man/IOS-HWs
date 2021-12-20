//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Роман on 20.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
    
    let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())

    var navigationController: UINavigationController

    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }


    func start() {
        feedCoordinator.start()
        loginCoordinator.start()
        feedCoordinator.parentCoordinator = self
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(feedCoordinator)
        childCoordinators.append(loginCoordinator)
    }    
}

