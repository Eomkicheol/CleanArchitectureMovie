//
//  HomeRouter.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
	func routeToNext()
}

protocol HomeDataPassing {
	var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {

	// MARK: - Properties

	weak var viewController: HomeViewController?
	var dataStore: HomeDataStore?

	// MARK: - Routing

	func routeToNext() { }

}
