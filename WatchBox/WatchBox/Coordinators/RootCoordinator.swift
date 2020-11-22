//
//  RootCoordinator.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit
import WBData

public class RootCoordinator: Coordinator {

    private lazy var searchFilmsViewModel: SearchFilmsViewModel = {
        let searchFilmsViewModel = SearchFilmsViewModel()
        searchFilmsViewModel.movieSelectedHandler = { [weak self] movie in
            self?.view(movie: movie)
        }
        return searchFilmsViewModel
    }()

    private lazy var favouritesMoveListViewModel: FavouritesMoveListViewModel = {
        let favouritesMoveListViewModel = FavouritesMoveListViewModel(searchFilmsViewModel: self.searchFilmsViewModel)

        favouritesMoveListViewModel.movieSelectedHandler = { [weak self] movie in
            self?.view(movie: movie)
        }
        return favouritesMoveListViewModel
    }()

    private lazy var favouritesMoveListViewController: FavouritesMoveListViewController = {
        let favoruitesMoveListViewController = FavouritesMoveListViewController(viewModel: self.favouritesMoveListViewModel)
        return favoruitesMoveListViewController
    }()


    public func start() {
        // Configure
    }

    private(set) lazy var defaultViewController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: self.favouritesMoveListViewController)
        return navigation
    }()

    public func view(movie: Movie) {
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)

        defaultViewController.pushViewController(movieDetailsViewController, animated: true)
    }
}
