//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//

import UIKit

import Kingfisher
import Then

class MovieCollectionViewCell: BaseCollectionViewCell {

	// MARK: Constants
	private enum Constants {
		static let labelFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
		static let subLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
		static let titleLabelColor: UIColor = UIColor.blue
		static let labelAlignment: NSTextAlignment = NSTextAlignment.left
		static let labelColor: UIColor = UIColor.darkGray
	}

	let movieImageView = UIImageView().then {
		$0.contentMode = .scaleToFill
		$0.clipsToBounds = true
	}

	let titleLabel = UILabel().then {
		$0.textColor = Constants.titleLabelColor
		$0.textAlignment = Constants.labelAlignment
		$0.font = Constants.labelFont
	}

	let subtitleLabel = UILabel().then {
		$0.textColor = Constants.labelColor
		$0.textAlignment = Constants.labelAlignment
		$0.font = Constants.subLabelFont
	}

	let actorLabel = UILabel().then {
		$0.textColor = Constants.labelColor
		$0.textAlignment = Constants.labelAlignment
		$0.numberOfLines = 0
		$0.font = Constants.subLabelFont
	}

	let directorLabel = UILabel().then {
		$0.textColor = Constants.labelColor
		$0.textAlignment = Constants.labelAlignment
		$0.font = Constants.subLabelFont
	}
	let userRatingLabel = UILabel().then {
		$0.textColor = Constants.labelColor
		$0.textAlignment = Constants.labelAlignment
		$0.font = Constants.subLabelFont
	}


	override func configureUI() {
		super.configureUI()

		self.contentView.backgroundColor = .white

		[movieImageView, titleLabel, subtitleLabel,
		 actorLabel, directorLabel, userRatingLabel].forEach {
			self.contentView.addSubview($0)
		}

		movieImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		movieImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

		self.movieImageView.snp.makeConstraints {
			$0.top.equalToSuperview().offset(15)
			$0.left.equalToSuperview().offset(5)
			$0.height.equalTo(155)
		}

		self.titleLabel.snp.makeConstraints {
			$0.top.equalTo(movieImageView)
			$0.left.equalTo(movieImageView.snp.right).offset(5)
			$0.right.equalToSuperview().offset(-15)
		}

		self.subtitleLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}

		self.actorLabel.snp.makeConstraints {
			$0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}

		self.directorLabel.snp.makeConstraints {
			$0.top.equalTo(actorLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
		}

		self.userRatingLabel.snp.makeConstraints {
			$0.top.equalTo(directorLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}
	}

	func setEntity(value: Item) {
		if let url = URL(string: value.image) {
			self.movieImageView.kf.setImage(with: url)
		}

		self.titleLabel.text = value.title.removeHTMLTag
		self.subtitleLabel.text = "( \(value.subtitle.removeHTMLTag))"
		self.actorLabel.text = "출연: \(value.actor.replacingComma.dropLast())"
		self.directorLabel.text = "감독: \(value.director.dropLast())"
		self.userRatingLabel.text = "평점: \(value.userRating)"

	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}

	static func cellHeight(width: CGFloat) -> CGSize {
		let height: CGFloat = 120 + Constants.labelFont.lineHeight + 25 +  Constants.subLabelFont.lineHeight

		return  CGSize(width: width, height: height)
	}
}

extension String {
	var removeHTMLTag: String {
		return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
	}

	var replacingComma: String {
		return self.replacingOccurrences(of: "|", with: ",", options: [.literal], range: nil)
	}
}
