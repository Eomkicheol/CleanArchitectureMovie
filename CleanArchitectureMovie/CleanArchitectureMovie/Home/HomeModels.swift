//
//  HomeModels.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum HomeModels {

	// MARK: - Use Cases

	enum FetchFromRemoteDataStore {
		struct Request {
			var movieTitle: String
		}

		struct Response {
			var request: Request
			var response: MovieItem?
		}

		struct ViewModel {
			var list: [Item]
		}
	}



	// MARK: - Types
	typealias HomeError = Error<HomeErrorType>


	enum HomeErrorType {
		case emptyExampleVariable, networkError
	}

	struct Error<T> {
		var type: T
		var message: String?

		init(type: T) {
			self.type = type
		}
	}
}
