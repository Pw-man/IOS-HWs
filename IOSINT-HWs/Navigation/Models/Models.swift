//
//  Models.swift
//  Navigation
//
//  Created by Роман on 12.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FeedViewControllerModel {

    private let storedPassword = "Pass"
        
    func check(word: String) -> Bool {
        if word.count != 0 && word == storedPassword  {
        return true
        } else {
            return false
        }
    }
}
