//
//  FeedViewControllerFactory.swift
//  Navigation
//
//  Created by Роман on 13.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewControllerFactory {
    func makeFeedViewContoller() -> FeedViewController
}

class MyFeedViewControllerFactory: FeedViewControllerFactory {
    func makeFeedViewContoller() -> FeedViewController {
        return FeedViewController(model: FeedViewControllerModel())
    }   
}
