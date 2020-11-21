//
//  RootCoordinator.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit
import WBData

protocol Coordinator {
    func start()
}

public class RootCoordinator: Coordinator {

    private lazy var searchFilmsViewModel: SearchFilmsViewModel = {
        let searchFilmsViewModel = SearchFilmsViewModel()
        searchFilmsViewModel.movieSelectedHandler = { [weak self] movie in
            self?.view(movie: movie)
        }
        return searchFilmsViewModel
    }()

    private lazy var favoruitesMoveListViewModel: FavoruitesMoveListViewModel = {
        let favoruitesMoveListViewModel = FavoruitesMoveListViewModel(searchFilmsViewModel: self.searchFilmsViewModel)

        favoruitesMoveListViewModel.movieSelectedHandler = { [weak self] movie in
            self?.view(movie: movie)
        }
        return favoruitesMoveListViewModel
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

    public func view(movie: Movie) {
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)

        defaultViewController.pushViewController(movieDetailsViewController, animated: true)
    }
}
