//
//  FavoruitesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import Foundation

import WBData
import WBPersistenceStore
import WBNetworking

public protocol ViewModel {

}

public class FilmListViewModel: ViewModel {

    let movieServiceProviding: MovieServiceProviding

    private(set) var movies: [Movie] = []

    public var movieSelectedHandler: ((Movie) -> Void)?

    public init(movieServiceProviding: MovieServiceProviding = MovieService()) {
        self.movieServiceProviding = movieServiceProviding
    }

    var numberOfFavoruties: Int {
        return movies.count
    }

    func update(movies: [Movie]) {
        self.movies = movies
    }

    func movie(at index: Int) -> Movie? {
        if index < movies.count {
            return movies[index]
        } else {
            return nil
        }
    }

    public func select(movie: Movie) {
        movieSelectedHandler?(movie)
    }
}

public class FavoruitesMoveListViewModel: FilmListViewModel {

    public let searchFilmsViewModel: SearchFilmsViewModel

    public init(searchFilmsViewModel: SearchFilmsViewModel = SearchFilmsViewModel()) {
        self.searchFilmsViewModel = searchFilmsViewModel
    }

    public func fetchFavourites(completion: ((_ movies: [Movie]) -> Void)) {
        let favourites = FavoruitesManager.default.fetchFavourites()
        self.update(movies: favourites)
        completion(favourites)
    }
}

public class SearchFilmsViewModel: FilmListViewModel {

    private var activeFetchRequest: URLSessionTask?
    private var activeSearchTerm: String?

    // Ideally would like to add some debouncing on here to ensure the API isnt bombarded with requests
    public func fetchMovies(with searchTerm: String?, plotType: PlotLength = .full, completion: @escaping ((_ movies: Movie?) -> Void)) {
        guard let searchTerm = searchTerm else {
            activeFetchRequest?.cancel()
            activeSearchTerm = nil
            update(movies: [])
            return
        }

        if activeFetchRequest != nil {
            self.activeFetchRequest?.cancel()
            self.activeSearchTerm = nil
        }

        let fetchMovieRequest = movieServiceProviding.fetchMovies(with: searchTerm, plotType: plotType) { [weak self] result in
            self?.activeSearchTerm = nil
            self?.activeFetchRequest = nil
            switch result {
            case .failure(let movieFetchError):
                self?.update(movies: [])
                completion(nil)
            case .success(let movie):
                self?.update(movies: [movie])
                completion(movie)
            }
        }

        activeFetchRequest = fetchMovieRequest
        activeSearchTerm = searchTerm
    }

}
