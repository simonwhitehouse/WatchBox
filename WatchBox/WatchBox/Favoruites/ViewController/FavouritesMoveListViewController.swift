//
//  FavouritesMoveListViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit
import WBData
import WBNetworking

public class FavouritesMoveListViewController: FilmListViewController {

    private let searchFilmsViewController: SearchFilmsViewController
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: self.searchFilmsViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search and add favourite film"
        return searchController
    }()

    private let viewModel: FavouritesMoveListViewModel

    public init(viewModel: FavouritesMoveListViewModel) {
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
        navigationItem.hidesSearchBarWhenScrolling = false

        definesPresentationContext = true

        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearButtonPressed))
        navigationItem.leftBarButtonItem = clearButton
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

    @objc
    private func clearButtonPressed() {
        let alertController = UIAlertController(title: "Clear Favourites?", message: "Are you sure you want to clear your favourites?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.clearFavourites()
            self?.refreshData()
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FavouritesMoveListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            // Ideally this logic to debounce would be in the model
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
                self?.searchFilmsViewController.fetchFilmes(with: self?.searchController.searchBar.text)
            }
        } else {
            refreshData()
        }
    }
}
