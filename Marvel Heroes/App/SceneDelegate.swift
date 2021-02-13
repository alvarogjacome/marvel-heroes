//
//  SceneDelegate.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private lazy var apiClient = MarvelHeroesAPIClient()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: HomeScreenViewController(apiClient: apiClient))
        window?.makeKeyAndVisible()
    }
}
