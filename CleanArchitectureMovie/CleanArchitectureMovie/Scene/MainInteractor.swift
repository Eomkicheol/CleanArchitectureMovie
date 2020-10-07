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
	func search(request: MainModels.FetchMovieList.Request)
}

protocol MainDataStore { }

final class MainInteractor: MainBusinessLogic, MainDataStore {

	typealias Models = MainModels

	// MARK: - Properties
	private var disposeBag: DisposeBag = DisposeBag()

	var presenter: MainPresentationLogic?

	private let worker: MainWorker

	init(worker: MainWorker) {
		self.worker = worker
	}

	func search(request: MainModels.FetchMovieList.Request) {
		_ = worker.search(request: request, compleation: { [weak self] items in
			guard let self = self else { return }
			let viewModel = Models.FetchMovieList.Response(movieTitle: request.movieTitle, response: items)
			self.presenter?.presentSearchDisplyMovieList(response: viewModel)
		}).disposed(by: self.disposeBag)
	}
}
