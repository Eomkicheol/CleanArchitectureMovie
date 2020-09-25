//
//  BaseCollectionViewCell.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}

	func configureUI() {}
}

