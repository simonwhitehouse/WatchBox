//
//  FavoruitesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import WBData
import WBPersistenceStore
import WBNetworking

public protocol ViewModel {

}

public class FavoruitesMoveListViewModel: ViewModel {

    private let movieServiceProviding: MovieServiceProviding

    private var favourites: [Movie] = []

    public init(movieServiceProviding: MovieServiceProviding = MovieService()) {
        self.movieServiceProviding = movieServiceProviding

        fetchMovies(with: "Inception")
    }

    public func fetchMovies(with searchTerm: String?, plotType: PlotLength = .full) {
        guard let searchTerm = searchTerm else { return }
        let fetchMovieRequest = movieServiceProviding.fetchMovies(with: searchTerm, plotType: plotType) { result in
            switch result {
            case .failure(let movieFetchError):
                break
            case .success(let movie):
                break
            }
        }
    }

    public func fetchFavourites(completion: ((_ movies: [Movie]) -> Void)) {
        let favourites = FavoruitesManager.default.fetchFavourites()
        self.favourites = favourites
        completion(favourites)
    }

    var numberOfFavoruties: Int {
        return favourites.count
    }

    func favouriteMovie(at index: Int) -> Movie? {
        if index < favourites.count {
            return favourites[index]
        } else {
            return nil
        }
    }
}

