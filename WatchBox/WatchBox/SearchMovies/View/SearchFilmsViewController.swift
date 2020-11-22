//
//  SearchFilmsViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

import WBNetworking

public class SearchFilmsViewController: FilmListViewController {

    private let viewModel: SearchFilmsViewModel

    public init(viewModel: SearchFilmsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isFetchingDataHandler = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    @objc
    public func fetchFilmes(with searchTerm: String?) {
        viewModel.fetchMovies(with: searchTerm) { [weak self] movies, error  in
            if let error = error {
                self?.showErrorAlert(for: error)
            }
            self?.tableView.reloadData()
        }
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isFetchingData {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as? LoadingTableViewCell else {
                return UITableViewCell()
            }

            cell.configure()
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }

    public func showErrorAlert(for error: MovieServiceError) {
        // TODO: Would look at error type here to inform user if need be. I.e. no internet connection
    }
}
