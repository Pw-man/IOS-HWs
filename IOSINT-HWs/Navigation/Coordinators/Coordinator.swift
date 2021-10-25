//
//  Coordinator.swift
//  Navigation
//
//  Created by Роман on 20.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set }
    
    func start()
}




