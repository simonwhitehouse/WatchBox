//
//  FavoruitesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import WBData
import WBNetworking

public protocol ViewModel {

}

public class FavoruitesMoveListViewModel: ViewModel {

    private let movieServiceProviding: MovieServiceProviding

    public init(movieServiceProviding: MovieServiceProviding = MovieService()) {
        self.movieServiceProviding = movieServiceProviding

        fetchMovies(with: "it")
    }

    public func fetchMovies(with searchTerm: String?, plotType: PlotLength = .full) {
        guard let searchTerm = searchTerm else { return }
        movieServiceProviding.fetchMovies(with: searchTerm, plotType: plotType) { result in
            switch result {
            case .failure(let movieFetchError):
                break
            case .success(let movies):
                break
            }
        }
    }
}

