//
//  MainPresenter.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
	func presentSearchDisplyMovieList(response: MainModels.FetchMovieList.Response)
}

final class MainPresenter: MainPresentationLogic {

	// MARK: - Properties
	weak var viewController: MainDisplayLogic?

	//MARK: - Methods
	func presentSearchDisplyMovieList(response: MainModels.FetchMovieList.Response) {
		let viewModel = MainModels.FetchMovieList.ViewModel(list: response.response?.items ?? [])
		viewController?.searchMovieTitle(viewModel: viewModel)
	}
}
