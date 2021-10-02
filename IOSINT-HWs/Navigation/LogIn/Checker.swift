//
//  Checker.swift
//  Navigation
//
//  Created by Роман on 02.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol CheckerProtocol {
    static var shared: Self { get }
    func checkUserData(enteredLogin: String, enteredPassword: String) -> Bool
}

final class Checker: CheckerProtocol {
    static let shared = Checker()
    
    private let login = "Sun"
    private let password = "qwe"
    
    private init() {
    }
    
    func checkUserData(enteredLogin: String, enteredPassword: String) -> Bool {
        if enteredLogin.hash == login.hash && enteredPassword.hash == password.hash {
            return true
        } else {
            return false
        }
    }
}
