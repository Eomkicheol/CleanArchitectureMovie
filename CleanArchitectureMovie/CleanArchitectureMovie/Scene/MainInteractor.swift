//
//  MainInteractor.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

protocol MainBusinessLogic {
	func displaySearch(with request: MainModels.FetchMovieList.Request)
}

protocol MainDataStore { }

class MainInteractor: MainBusinessLogic, MainDataStore {

	typealias Models = MainModels

	// MARK: - Properties
	var disposeBag: DisposeBag = DisposeBag()

	var presenter: MainPresentationLogic?

	let worker: MainWorker

	init(worker: MainWorker) {
		self.worker = worker
	}

	func displaySearch(with request: MainModels.FetchMovieList.Request) {
		_ = worker.search(request: request, compleation: { items in
			let viewModel = Models.FetchMovieList.Response(request: request, response: items)
			self.presenter?.searchDisplyMovieList(with: viewModel)
		}).disposed(by: self.disposeBag)
	}
}
