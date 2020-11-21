//
//  FavoruitesMoveListViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit
import WBData
import WBNetworking



public class FavoruitesMoveListViewController: FilmListViewController {

    private let searchFilmsViewController: SearchFilmsViewController

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: self.searchFilmsViewController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search and add favourite film"
        return searchController
    }()

    private let viewModel: FavoruitesMoveListViewModel

    public init(viewModel: FavoruitesMoveListViewModel) {
        self.viewModel = viewModel
        self.searchFilmsViewController = SearchFilmsViewController(viewModel: viewModel.searchFilmsViewModel)
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refreshData()
    }

    private func refreshData() {
        viewModel.fetchFavourites { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}

extension FavoruitesMoveListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            searchFilmsViewController.fetchFilmes(with: searchController.searchBar.text)
        } else {
            // Ensures that any changes to favoruites are reflected
            refreshData()
        }
    }
}
