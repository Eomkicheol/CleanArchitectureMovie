//
//  HomeWorker.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

import RxSwift
import Moya

protocol HomeWorkerNetworking {
	func search(request: HomeModels.FetchFromRemoteDataStore.Request, compleation: @escaping (MovieItem) -> Void)
}

class HomeWorker: HomeWorkerNetworking {

	// MARK: - Properties

	typealias Models = HomeModels

	let disposeBag = DisposeBag()

	private let networking: NetworkingProtocol

	init(networking: NetworkingProtocol) {
		self.networking = networking
	}

	// MARK: - Methods

	func search(request: HomeModels.FetchFromRemoteDataStore.Request, compleation: @escaping (MovieItem) -> Void) {
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
