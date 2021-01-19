//
//  SceneDelegate.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import UIKit

// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public properties
    
    var window: UIWindow?
    
    // MARK: - Private properties
    
    private let navigationController = UINavigationController()
    
    // MARK: - Public methods
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let coordinator = Coordinator(navigationController: navigationController)
        coordinator.start()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
