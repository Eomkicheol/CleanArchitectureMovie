//
//  MainModels.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MainModels {

    // MARK: - Use Cases
	enum FetchMovieList {
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
}
