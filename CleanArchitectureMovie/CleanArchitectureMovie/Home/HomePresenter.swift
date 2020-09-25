//
//  HomePresenter.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
	func presentSearch(with response: HomeModels.FetchFromRemoteDataStore.Response)
}

class HomePresenter: HomePresentationLogic {

	// MARK: - Properties

	typealias Models = HomeModels
	weak var viewController: HomeDisplayLogic?


	// MARK: - Use Case - Fetch From Remote DataStore

	func presentSearch(with response: HomeModels.FetchFromRemoteDataStore.Response) {

		let viewModel = Models.FetchFromRemoteDataStore.ViewModel(list: response.response?.items ?? [])
		viewController?.displayFetchFromRemoteDataStore(with: viewModel)
	}
}
