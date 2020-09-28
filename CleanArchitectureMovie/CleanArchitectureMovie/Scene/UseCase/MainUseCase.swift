//
//  MainUseCase.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/28.
//

import Foundation

import Moya
import RxSwift
import RxCocoa

protocol MainUseCaseProtocol: class {
	func searchMovieList(movieTitle: String) -> Single<Response>
}

class MainUseCase: MainUseCaseProtocol {

	private let movieService: MainRepositoryProtocol

	init(movieService: MainRepositoryProtocol) {
		self.movieService = movieService
	}

	func searchMovieList(movieTitle: String) -> Single<Response> {
		return self.movieService.searchMovieList(movieTitle: movieTitle)
	}
}

