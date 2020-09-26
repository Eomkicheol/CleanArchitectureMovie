//
//  MainViewController.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
	func searchMovieTitle(with viewModel: MainModels.FetchMovieList.ViewModel)
}

class MainViewController: BaseViewController, MainDisplayLogic {

	// MARK: - Properties
	
	var viewModel: Models.FetchMovieList.ViewModel? {
		didSet {
			self.updateUI()
		}
	}

	typealias Models = MainModels
	var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
	var interactor: MainBusinessLogic?

	let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

	// MARK: - UIProperties

	lazy var searchBar = UISearchBar().then {
		$0.placeholder = "검색어를 입력해 주세요"
		$0.searchBarStyle = .prominent
		$0.autocorrectionType = .no
		$0.autocapitalizationType = .none

	}

	lazy var collectView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout).then {
		$0.alwaysBounceVertical = true
		$0.showsVerticalScrollIndicator = true
		$0.backgroundColor = .clear
		$0.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
		$0.keyboardDismissMode = .onDrag

		//cell
		$0.register(MainMoviceCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	}

	// MARK: - Object lifecycle

	override init() {
		super.init()
		defer {
			setup()
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: - Setup

	private func setup() {
		let viewController = self
		let interactor = MainInteractor()
		let presenter = MainPresenter()
		let router = MainRouter()

		viewController.router = router
		viewController.interactor = interactor
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}

	// MARK: - View Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureUI() {
		super.configureUI()

		self.navigationSetting()
		self.view.backgroundColor = UIColor(white: 0.9, alpha: 1)

		[searchBar, collectView].forEach {
			self.view.addSubview($0)
		}
	}

	override func setupConstraints() {
		super.setupConstraints()

		self.searchBar.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.left.right.equalToSuperview()
		}

		self.collectView.snp.makeConstraints {
			$0.top.equalTo(searchBar.snp.bottom).offset(5)
			$0.left.right.bottom.equalToSuperview()
		}
	}

	func navigationSetting() {
		navigationItem.title = "영화검색"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.hidesBarsOnSwipe = true
	}

	func searchMovieTitle(with viewModel: MainModels.FetchMovieList.ViewModel) {
		self.viewModel = viewModel
	}

	private func updateUI() {
		DispatchQueue.main.async {
			self.collectView.reloadData()
		}
	}
}


extension MainViewController: UICollectionViewDelegate { }


extension MainViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel?.list.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainMoviceCollectionViewCell else { return UICollectionViewCell() }
		cell.setEntity(value: self.viewModel?.list[indexPath.row] ?? Item())
		return cell
	}
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return MainMoviceCollectionViewCell.cellHeight(width: collectionView.bounds.width)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: 0, bottom: 0, right: 0)
	}
}


extension MainViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request = MainModels.FetchMovieList.Request(movieTitle: searchBar.text ?? "")
		self.interactor?.displaySearch(with: request)
	}
}
