//
//  MainPresenter.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
	func searchDisplyMovieList(with response: MainModels.FetchMovieList.Response)
}

class MainPresenter: MainPresentationLogic {
	// MARK: - Properties

	typealias Models = MainModels
	weak var viewController: MainDisplayLogic?

	func searchDisplyMovieList(with response: MainModels.FetchMovieList.Response) {
		let viewModel = Models.FetchMovieList.ViewModel(list: response.response?.items ?? [])
		viewController?.searchMovieTitle(with: viewModel)
	}
}
