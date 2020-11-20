//
//  SceneDelegate.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene

        let rootCoordinator = RootCoordinator()
        self.rootCoordinator = rootCoordinator

        appWindow.rootViewController = rootCoordinator.defaultViewController
        appWindow.makeKeyAndVisible()

        self.window = appWindow
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
