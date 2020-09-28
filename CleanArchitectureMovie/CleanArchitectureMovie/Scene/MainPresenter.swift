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

	typealias Models = MainModels

	// MARK: - Properties
	weak var viewController: MainDisplayLogic?

	//MARK: - Methods
	func searchDisplyMovieList(with response: MainModels.FetchMovieList.Response) {
		let viewModel = Models.FetchMovieList.ViewModel(list: response.response?.items ?? [])
		viewController?.searchMovieTitle(with: viewModel)
	}
}
