//
//  User.swift
//  StorageService
//
//  Created by Роман on 18.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

public protocol UserService {
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

