//
//  MainWorker.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

protocol MainWorkerNetworking {
	func search(request: MainModels.FetchMovieList.Request, compleation: @escaping (MovieItem) -> Void) -> Disposable
}

class MainWorker: MainWorkerNetworking {

	typealias Models = MainModels

	// MARK: - Properties
	let movieService: MainUseCaseProtocol

	init(movieService: MainUseCaseProtocol) {
		self.movieService = movieService
	}

	// MARK: - Methods
	func search(request: MainModels.FetchMovieList.Request, compleation: @escaping (MovieItem) -> Void) -> Disposable {

		self.movieService.searchMovieList(movieTitle: request.movieTitle)
			.map(MovieItem.self)
			.subscribe(onSuccess: { items in
				compleation(items)
			}, onError: { _ in
				print("에러!!!!!!!")
			})
	}
}
