//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Роман on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let infoVC = InfoViewController()
        navigationController.present(infoVC, animated: true, completion: nil)
    }
}
