//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 27/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        window?.rootViewController = navigationController
        
        let vc = MoviesListFactory.makeMoviesListViewController()
        
        navigationController.pushViewController(vc, animated: true)
        
        window?.makeKeyAndVisible()
    }
}

