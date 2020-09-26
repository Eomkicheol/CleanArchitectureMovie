//
//  MainInteractor.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
	func displaySearch(with request: MainModels.FetchMovieList.Request)
}

protocol MainDataStore { }

class MainInteractor: MainBusinessLogic, MainDataStore {

	// MARK: - Properties

	typealias Models = MainModels

	lazy var worker = MainWorker(networking: Networking())
	var presenter: MainPresentationLogic?

	func displaySearch(with request: MainModels.FetchMovieList.Request) {
		worker.search(request: request, compleation: { items in
			let viewModel = Models.FetchMovieList.Response(request: request, response: items)
			self.presenter?.searchDisplyMovieList(with: viewModel)
		})
	}
}
