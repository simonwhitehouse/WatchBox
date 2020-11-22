//
//  SearchFilmsViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import Foundation

public class SearchFilmsViewController: FilmListViewController {

    private let viewModel: SearchFilmsViewModel

    public init(viewModel: SearchFilmsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    public func fetchFilmes(with searchTerm: String?) {
        viewModel.fetchMovies(with: searchTerm) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}
