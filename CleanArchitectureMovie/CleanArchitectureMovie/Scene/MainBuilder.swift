//
//  MainBuilder.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/28.
//

import Foundation

import UIKit

class MainBuilder {

	static func buildModule(viewController: MainDisplayLogic) {

		let repository = MainRepository()
		let useCase = MainUseCase(movieService: repository)
		let worker = MainWorker(movieService: useCase)
		let interactor = MainInteractor(worker: worker)
		let presenter = MainPresenter()
		let router = MainRouter()

		viewController.presenter = presenter
		viewController.interactor = interactor
		viewController.router = router

		router.dataStore = interactor
		presenter.viewController = viewController
		interactor.presenter = presenter
	}
}
