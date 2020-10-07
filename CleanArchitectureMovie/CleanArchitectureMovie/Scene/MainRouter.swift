//
//  MainRouter.swift
//  CleanArchitectureMovie
//
//  Created by 엄기철 on 2020/09/26.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
    func routeToNext()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

final class MainRouter: MainRoutingLogic, MainDataPassing {

    // MARK: - Properties
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

    // MARK: - Routing
    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing
    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MainDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
