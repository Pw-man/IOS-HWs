
//  SceneDelegate.swift
//  Navigation
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.

import UIKit
import StorageService

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let myLoginFactory = MyLoginFactory()
    
    var window: UIWindow?

    let mainTabBarVC = MainTabBarController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = mainTabBarVC
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

