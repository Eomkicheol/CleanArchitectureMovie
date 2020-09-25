//
//  AccessTokenPlugin.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//

import UIKit

import Moya

final class AccessTokenPlugin: PluginType {
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		let request = request

		return request
	}
}
