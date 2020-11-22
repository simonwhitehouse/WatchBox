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

    private(set) var movies: [MovieRepresentable] = []

    public var movieSelectedHandler: ((MovieRepresentable) -> Void)?

    public init(movieServiceProviding: MovieServiceProviding = MovieService()) {
        self.movieServiceProviding = movieServiceProviding
    }

    var numberOfFavourites: Int {
        return movies.count
    }

    func update(movies: [MovieRepresentable]) {
        self.movies = movies
    }

    func movie(at index: Int) -> MovieRepresentable? {
        if index < movies.count {
            return movies[index]
        } else {
            return nil
        }
    }

    public func select(movie: MovieRepresentable) {
        movieSelectedHandler?(movie)
    }
}
