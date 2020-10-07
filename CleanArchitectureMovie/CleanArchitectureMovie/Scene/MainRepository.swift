//
//  MainRepository.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/28.
//

import Foundation

import Moya
import RxSwift
import RxCocoa

protocol MainRemoteRepositoryProtocol: class {
	func searchMovieList(movieTitle: String) -> Single<Response>
}

protocol MainLocalRepositoryProtocol  {}

protocol MainRepositoryProtocol: MainRemoteRepositoryProtocol, MainLocalRepositoryProtocol {}

final class MainRepository: MainRepositoryProtocol {

	let network: NetworkingProtocol

	init(network: NetworkingProtocol = Networking()) {
		self.network = network
	}

	func searchMovieList(movieTitle: String) -> Single<Response> {
		return self.network.request(AppApi.search(keyword: movieTitle))
	}
}
