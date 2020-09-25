//
//  AppAPI.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/19.
//

import UIKit

import Moya

enum AppApi {
	case search(keyword: String)
}

extension AppApi: TargetType {

	var baseURL: URL {
		return URL(string: "https://openapi.naver.com/v1/search")!
	}

	var path: String {
		switch self {

			case .search:
				return "/movie.json"
		}
	}

	var method: Moya.Method {
		switch self {
			case .search:
				return .get
		}
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
		switch self {
			case .search:
				return .requestParameters(parameters: parameters!, encoding: parametersEncoding)
		}
	}

	var parameters: [String: Any]? {
		switch self {
			case .search(let movieName):
				return ["query": movieName]
		}
	}

	var parametersEncoding: ParameterEncoding {
		switch self {
			case .search:
				return URLEncoding.queryString
		}
	}

	var headers: [String: String]? {
		return [
			"X-Naver-Client-Id": "_1bqwNnAX32fFsiO79Bk",
			"X-Naver-Client-Secret": "HhvulWTnan"]
	}
}
