//
//  HomeInteractor.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

protocol HomeBusinessLogic {
	func displaySearch(with request: HomeModels.FetchFromRemoteDataStore.Request)
}

protocol HomeDataStore { }

class HomeInteractor: HomeBusinessLogic, HomeDataStore {

	// MARK: - Properties

	typealias Models = HomeModels

	let disposeBag = DisposeBag()

	lazy var worker = HomeWorker(networking: Networking())
	var presenter: HomePresentationLogic?


	// MARK: - Use Case - Fetch From Remote DataStore

	func displaySearch(with request: HomeModels.FetchFromRemoteDataStore.Request) {
		// fetch something from backend and return the values here

		worker.search(request: request, compleation: { items in
			let viewModel = Models.FetchFromRemoteDataStore.Response(request: request, response: items)
			self.presenter?.presentSearch(with: viewModel)
		})
	}
}
