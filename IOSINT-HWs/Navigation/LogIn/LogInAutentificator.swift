//
//  LogInAutentificator.swift
//  Navigation
//
//  Created by Роман on 02.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LoginFactory {
    func makeLogInLogInAutentificator() -> LogInAutentificator
}

protocol LogInViewControllerDelegate {
    func enterConfirmation(login: String, password: String) -> Bool
}

struct LogInAutentificator: LogInViewControllerDelegate {
    
    private let checker: Checker
    
    init(checker: Checker) {
        self.checker = checker
    }
    
    func enterConfirmation(login: String, password: String) -> Bool {
        if checker.checkUserData(enteredLogin: login, enteredPassword: password) {
            return true
        } else {
            return false
        }
    }
}

class MyLoginFactory: LoginFactory {
    func makeLogInLogInAutentificator() -> LogInAutentificator {
        return LogInAutentificator(checker: Checker.shared)
    }
}
