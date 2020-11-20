//
//  RootCoordinator.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit

protocol Coordinator {
    func start()
}

public class RootCoordinator: Coordinator {

    private lazy var favoruitesMoveListViewModel: FavoruitesMoveListViewModel = {
        return FavoruitesMoveListViewModel()
    }()

    private lazy var favoruitesMoveListViewController: FavoruitesMoveListViewController = {
        let favoruitesMoveListViewController = FavoruitesMoveListViewController(viewModel: self.favoruitesMoveListViewModel)
        return favoruitesMoveListViewController
    }()


    public func start() {
        // Configure
    }

    private(set) lazy var defaultViewController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: self.favoruitesMoveListViewController)
        return navigation
    }()
}
