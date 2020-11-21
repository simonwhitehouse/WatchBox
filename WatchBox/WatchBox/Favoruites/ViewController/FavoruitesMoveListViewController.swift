//
//  FavoruitesMoveListViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit
import WBData
import WBNetworking

public class FilmListViewController: UIViewController {

    private let viewModel: FilmListViewModel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavouriteMovieListTableViewCell.self, forCellReuseIdentifier: "FavouriteMovieListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favourites"

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    public init(viewModel: FilmListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

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


extension FilmListViewController: UITableViewDelegate, UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFavoruties
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteMovieListTableViewCell", for: indexPath) as? FavouriteMovieListTableViewCell, let movie = viewModel.movie(at: indexPath.row) else {
            return UITableViewCell()
        }

        cell.configure(movie: movie)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.movie(at: indexPath.row) else { return }
        viewModel.select(movie: movie)
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

public class SearchFilmsViewController: FilmListViewController {

    private let viewModel: SearchFilmsViewModel

    public init(viewModel: SearchFilmsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fetchFilmes(with searchTerm: String?) {
        viewModel.fetchMovies(with: searchTerm) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}


public class MovieDetailsViewModel {

    let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
    }

    public var title: String {
        return movie.title
    }

}

public class MovieDetailsViewController: UIViewController {

    private let viewModel: MovieDetailsViewModel

    public init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavouriteMovieListTableViewCell.self, forCellReuseIdentifier: "FavouriteMovieListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // title, favourite button, plot
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteMovieListTableViewCell", for: indexPath) as? FavouriteMovieListTableViewCell else {
            return UITableViewCell()
        }

        let movie = viewModel.movie
        cell.configure(movie: movie)
        return cell
    }
}
