//
//  HomeViewController.swift
//  Movie
//
//  Created by 엄기철 on 2020/09/18.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

import SnapKit
import Then

protocol HomeDisplayLogic: class {
	func displayFetchFromRemoteDataStore(with viewModel: HomeModels.FetchFromRemoteDataStore.ViewModel)
}

class HomeViewController: BaseViewController, HomeDisplayLogic {

	// MARK: - Properties

	var viewModel: Models.FetchFromRemoteDataStore.ViewModel? {
		didSet {
			self.updateUI()
		}
	}

	typealias Models = HomeModels
	var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
	var interactor: HomeBusinessLogic?

	let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

	lazy var searchBar = UISearchBar().then {
		$0.placeholder = "검색어를 입력해 주세요"
		$0.searchBarStyle = .prominent
		$0.autocorrectionType = .no
		$0.autocapitalizationType = .none
		$0.delegate = self
	}

	lazy var collectView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout).then {
		$0.alwaysBounceVertical = true
		$0.showsVerticalScrollIndicator = true
		$0.backgroundColor = .clear
		$0.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
		$0.keyboardDismissMode = .onDrag
		$0.delegate = self
		$0.dataSource = self
		//cell
		$0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
		let interactor = HomeInteractor()
		let presenter = HomePresenter()
		let router = HomeRouter()

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
		view.backgroundColor = .white
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
		navigationItem.title = "Home"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.hidesBarsOnSwipe = true
	}


	// MARK: - Use Case - Fetch From Remote DataStore

	func displayFetchFromRemoteDataStore(with viewModel: HomeModels.FetchFromRemoteDataStore.ViewModel) {
		self.viewModel = viewModel
	}

	private func updateUI() {
		DispatchQueue.main.async {
			self.collectView.reloadData()
		}
	}
}


extension HomeViewController: UICollectionViewDelegate { }


extension HomeViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel?.list.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }

		cell.setEntity(value: self.viewModel?.list[indexPath.row] ?? Item())

		return cell
	}
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return MovieCollectionViewCell.cellHeight(width: collectionView.bounds.width)
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


extension HomeViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request = HomeModels.FetchFromRemoteDataStore.Request(movieTitle: searchBar.text ?? "")
		interactor?.displaySearch(with: request)
	}

}
