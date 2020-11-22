//
//  MovieDetailsViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

import WBData

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
        tableView.register(FavouriteMovieListTableViewCell.self, forCellReuseIdentifier: FavouriteMovieListTableViewCell.reuseIdentifier)
        tableView.register(FavouriteButtonTableViewCell.self, forCellReuseIdentifier: FavouriteButtonTableViewCell.reuseIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        tableView.register(RateMovieTableViewCell.self, forCellReuseIdentifier: RateMovieTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
        return 2
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteMovieListTableViewCell.reuseIdentifier, for: indexPath) as? FavouriteMovieListTableViewCell else {
                    return UITableViewCell()
                }

                let movie = viewModel.movie
                cell.configure(movie: movie, hidePlot: true)
                cell.selectionStyle = .none
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RateMovieTableViewCell.reuseIdentifier, for: indexPath) as? RateMovieTableViewCell else {
                    return UITableViewCell()
                }

                cell.configure(with: viewModel.usersRating)
                cell.ratingChangedHandler = { [weak self] rating in
                    self?.viewModel.updateRating(rating)
                }
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteButtonTableViewCell.reuseIdentifier, for: indexPath) as? FavouriteButtonTableViewCell else {
                    return UITableViewCell()
                }

                cell.configure(isFavourite: viewModel.isFavourite)
                cell.favouriteButtonPressedHandler = { [weak self] isFavourite in
                    self?.viewModel.toggleFavourite(isFavourite: isFavourite)
                }
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.reuseIdentifier, for: indexPath) as? TextTableViewCell else {
                    return UITableViewCell()
                }

                cell.configure(text: viewModel.plot)
                return cell
            default:
                return UITableViewCell()
            }
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.reuseIdentifier, for: indexPath) as? TextTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(text: viewModel.actors ?? "No actor information")
            return cell
        }

    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Actors"
        } else {
            return nil
        }
    }
}
