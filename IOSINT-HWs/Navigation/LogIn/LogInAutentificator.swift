//
//  LogInAutentificator.swift
//  Navigation
//
//  Created by Роман on 02.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

protocol LoginAutentificatorDelegate {
    func presentAlertController(alertController: UIAlertController)
    func pushProfileViewController(viewController: ProfileViewController)
}

import UIKit
import FirebaseAuth
import StorageService

class LogInAutentificator {
    
    weak var loginVCDelegate: LogInViewController?
    
    func enterConfirmation(mail: String, password: String) {
        let userService: UserService = SchemeCheck.isInDebugMode ? TestUserService() : CurrentUserService()
        guard password.isEmpty == false && mail.isEmpty == false else {
            let alertController = UIAlertController(title: "Email or password field is empty", message: "Please, fill in all the input fields", preferredStyle: .alert)
            let userTapToContinue = UIAlertAction(title: "Continue", style: .default) { _ in
                print("User исправляет введённые данные")
            }
            alertController.addAction(userTapToContinue)
            loginVCDelegate?.presentAlertController(alertController: alertController)
            return
        }
        Auth.auth().signIn(withEmail: mail, password: password) { result, err in
            guard let user = result?.user, err == nil else {
                print(err!.localizedDescription)
                Auth.auth().createUser(withEmail: mail, password: password) { [weak self] authResult, error in
                    guard let self = self else { return }
                    guard let user = authResult?.user, error == nil else {
                        let alertControllerTwo = UIAlertController(title: "\(error!.localizedDescription)", message: "Check the data validity", preferredStyle: .alert)
                        let userTapToContinueTwo = UIAlertAction(title: "Fix", style: .default)
                        alertControllerTwo.addAction(userTapToContinueTwo)
                        self.loginVCDelegate?.presentAlertController(alertController: alertControllerTwo)
                        return
                    }
                    print("\(user.email!) created!")
                    let alertControllerThree = UIAlertController(title: "User: \(user.email!) created!", message: "", preferredStyle: .alert)
                    let userTapToContinueThree = UIAlertAction(title: "Continue", style: .default) { _ in }
                    alertControllerThree.addAction(userTapToContinueThree)
                    self.loginVCDelegate?.presentAlertController(alertController: alertControllerThree)
                }
                return
            }
            guard let reseivedEmail = user.email else { return }
            let profileVC = ProfileViewController(user: userService, name: reseivedEmail)
            self.loginVCDelegate?.pushProfileViewController(viewController: profileVC)
        }
    }
}

