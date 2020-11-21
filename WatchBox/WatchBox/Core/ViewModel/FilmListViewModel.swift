//
//  FilmListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import WBNetworking
import WBData

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
