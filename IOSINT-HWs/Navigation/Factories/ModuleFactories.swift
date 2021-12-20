//
//  FeedViewControllerFactory.swift
//  Navigation
//
//  Created by Роман on 13.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol CustomViewController {

    var viewModel: ViewInput & ViewOutput { get set }
    
    init(viewModel: ViewInput & ViewOutput)
}

typealias MVVMController = UIViewController & CustomViewController

protocol FeedModuleFactory {
    func makeVC() -> FeedViewController
}

protocol PostModuleFactory {
    func makeVC() -> PostViewController
}

protocol InfoModuleFactory {
    func makeVC() -> InfoViewController
}

enum Modules {
    case feedVC
    case postVC
    case infoVC
}
