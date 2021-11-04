//
//  Constants.swift
//  Navigation
//
//  Created by Роман on 05.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds

struct SchemeCheck {
    static var isInDebugMode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}

