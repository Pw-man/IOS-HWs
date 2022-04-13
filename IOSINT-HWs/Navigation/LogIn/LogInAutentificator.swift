//
//  LogInAutentificator.swift
//  Navigation
//
//  Created by Роман on 02.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

protocol LoginAutentificatorDelegate {
    func presentAlertController(title: String, message: String, actionMessage: String)
    func pushProfileViewController(user: UserService, name: String)
}

import Foundation
import FirebaseAuth
import StorageService

class LogInAutentificator {
    
    weak var loginVCDelegate: LogInViewController?
    
    func performAuthorization(user: UserService, name: String) {
        self.loginVCDelegate?.pushProfileViewController(user: user, name: name)
    }
    
    func createUser(mail: String, password: String) {
        Auth.auth().createUser(withEmail: mail, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard let user = authResult?.user, error == nil else {
                self.loginVCDelegate?.presentAlertController(title: error!.localizedDescription, message: "Check the data validity".localized(), actionMessage: "Fix".localized())
                return
            }
            print("\(user.email!) created!")
            self.loginVCDelegate?.presentAlertController(title: "User: ".localized() + "\(user.email!)" + "created!".localized(), message: "", actionMessage: "Continue".localized())
        }
    }
    
    func enterConfirmation(mail: String, password: String) {
        let userService: UserService = SchemeCheck.isInDebugMode ? TestUserService() : CurrentUserService()
        guard password.isEmpty == false || mail.isEmpty == false else {
            loginVCDelegate?.presentAlertController(title: "Email and password field are empty".localized(), message: "Please, fill in all input fields".localized(), actionMessage: "Continue".localized())
            print("User вводит данные")
            return
        }
        Auth.auth().signIn(withEmail: mail, password: password) { result, err in
            guard let user = result?.user, err == nil else {
                print(err!.localizedDescription)
                self.createUser(mail: mail, password: password)
                return
            }
            self.performAuthorization(user: userService, name: user.email!)
        }
    }
}

