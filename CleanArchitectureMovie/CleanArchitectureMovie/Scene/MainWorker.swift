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
	func search(request: MainModels.FetchMovieList.Request, compleation: @escaping (MovieItem) -> Void)
}

class MainWorker: MainWorkerNetworking {

	// MARK: - Properties

	typealias Models = MainModels

	let disposeBag = DisposeBag()

	private let networking: NetworkingProtocol

	init(networking: NetworkingProtocol) {
		self.networking = networking
	}

	// MARK: - Methods

	func search(request: MainModels.FetchMovieList.Request, compleation: @escaping (MovieItem) -> Void) {
		self.networking.request(AppApi.search(keyword: request.movieTitle))
			.map(MovieItem.self)
			.subscribe(onSuccess: { items in
				compleation(items)
			}, onError: { _ in
				print("에러!!!!!!!")
			})
			.disposed(by: self.disposeBag)
	}
}
