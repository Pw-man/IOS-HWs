//
//  ModuleFactory.swift
//  Navigation
//
//  Created by Роман on 24.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

//protocol Module {
//
//    var viewController: UIViewController { get }
//}

class FeedModule {
    
    var viewController: FeedViewController
    
    init(viewController: FeedViewController) {
        self.viewController = viewController
    }
}

protocol FeedModuleFactory {
    
    func makeModule() -> FeedModule
}

class myFeedModelFactory: FeedModuleFactory {
    func makeModule() -> FeedModule {
        let myFeedViewControllerFactory = MyFeedViewControllerFactory()
        return FeedModule(viewController: myFeedViewControllerFactory.makeFeedViewContoller())
    }
}



