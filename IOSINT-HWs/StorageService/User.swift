//
//  User.swift
//  StorageService
//
//  Created by Роман on 18.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

public protocol LoginFactory {
    func makeLogInLogInAutentificator() -> LogInAutentificator
}

public class AppRouter {
    public var typedLogname: String?
    public var typedPass: String?
    var encryptedLogin: AnyHashable?
    var encryptedPassword: AnyHashable?
}

public final class Checker {
    static let shared = Checker()
    
    private let login = "Sun"
    private let password = "qwe"
    
    public var router = AppRouter()

    private init() {
        router.encryptedLogin = login.hash
        router.encryptedPassword = password.hash
    }
}

public let checker = Checker.shared

public struct LogInAutentificator: LogInViewControllerDelegate {
    public init() {}
    
    public func checkUserData() -> Bool {
        if checker.router.typedLogname?.hash == checker.router.encryptedLogin && checker.router.typedPass?.hash == checker.router.encryptedPassword {
   return true
        } else {
            return false
        }
    }
    }

public protocol UserService: AnyObject {
    func returnUser(name: String) -> User
}

public class TestUserService: UserService {
    public init() {}
    public let user = User(fullName: "Sun", avatar: UIImage(systemName: "sun.max")!, status: "Shining")
    public func returnUser(name: String) -> User {
        guard name == user.fullName else { return User(fullName: "Unidentified user", avatar: UIImage(systemName: "questionmark.circle")!, status: "Who am I?")}
        return user
    }
}

public class User {
    
    public var fullName: String
    public var avatar: UIImage
    public var status: String
    
    public init(fullName: String, avatar: UIImage, status: String ) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

public class CurrentUserService: UserService {
    public init() {}
    public var user = User(fullName: "Coolest Dog Ever", avatar: UIImage(named: "dachshundPhoto")!, status: "Hello buddy")
    public func returnUser(name: String) -> User {
        guard name == user.fullName else { return User(fullName: "Unidentified user", avatar: UIImage(systemName: "questionmark.circle")!, status: "Who am I?")}
        return user
    }
}

public protocol LogInViewControllerDelegate {
   mutating func checkUserData() -> Bool
}

public class MyLoginFactory: LoginFactory {
    public init() {}
    public func makeLogInLogInAutentificator() -> LogInAutentificator {
        return LogInAutentificator()
    }
    
    
}
///                              Код к вопросу 2 ↓
//extension AppRouter: LoginFactory {
//    public func makeLogInLogInAutentificator() -> LogInAutentificator {
//        return LogInAutentificator()
//    }
//}

