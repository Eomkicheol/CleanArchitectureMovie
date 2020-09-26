//
//  SceneDelegate.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		self.window = window

		self.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
		self.window?.backgroundColor = .white

		self.window?.makeKeyAndVisible()
	}
}

