//
//  FilmListViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

public class FilmListViewController: UIViewController {

    private let viewModel: FilmListViewModel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavouriteMovieListTableViewCell.self, forCellReuseIdentifier: "FavouriteMovieListTableViewCell")
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.separatorInset = .zero
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

extension FilmListViewController: UITableViewDelegate, UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsToDisplay
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.noMoviesToDisplay {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(text: viewModel.noMoviesToDisplayInformationString, textAlignment: .center)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteMovieListTableViewCell", for: indexPath) as? FavouriteMovieListTableViewCell, let movie = viewModel.movie(at: indexPath.row) else {
                return UITableViewCell()
            }

            cell.configure(movie: movie)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.movie(at: indexPath.row) else { return }
        viewModel.select(movie: movie)
    }
}
