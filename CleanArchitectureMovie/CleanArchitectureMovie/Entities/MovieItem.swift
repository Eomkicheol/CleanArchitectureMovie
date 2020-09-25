//
//  MovieItem.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//

import Foundation

struct MovieItem: Codable {
	// MARK: Properties
	var items: [Item] = []

	enum CodingKeys: String, CodingKey {
		case items
	}
}

struct Item: Codable {
	let title: String
	let link: String
	let image: String
	let subtitle, pubDate, director, actor: String
	let userRating: String


	init() {
		title = ""
		link = ""
		image = ""
		subtitle = ""
		pubDate = ""
		director = ""
		actor = ""
		userRating = ""
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decode(String.self, forKey: .title)
		link = try values.decode(String.self, forKey: .link)
		image = try values.decode(String.self, forKey: .image)
		subtitle = try values.decode(String.self, forKey: .subtitle)
		pubDate = try values.decode(String.self, forKey: .pubDate)
		director = try values.decode(String.self, forKey: .director)
		actor = try values.decode(String.self, forKey: .actor)
		userRating = try values.decode(String.self, forKey: .userRating)
	}
}
