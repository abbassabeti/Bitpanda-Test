//
//  SceneDelegate.swift
//  BitPandaTest
//
//  Created by Abbas on 2/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = MainTabController()
        viewController.view.frame = UIScreen.main.bounds
        let coordinator = MainCoordinator()
        viewController.setCoordinator(coordinator: coordinator)
        self.window = window
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

