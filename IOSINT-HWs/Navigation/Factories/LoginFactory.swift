//
//  LoginFactory.swift
//  Navigation
//
//  Created by Роман on 02.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LoginFactory {
    func makeLogInLogInAutentificator() -> LogInAutentificator
}

class MyLoginFactory: LoginFactory {
    func makeLogInLogInAutentificator() -> LogInAutentificator {
        return LogInAutentificator()
    }
}
