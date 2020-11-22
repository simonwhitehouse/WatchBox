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
    public var isFetchingDataHandler: ((Bool) -> Void)?

    public init(movieServiceProviding: MovieServiceProviding = MovieService()) {
        self.movieServiceProviding = movieServiceProviding
    }

    var numberOfRowsToDisplay: Int {
        return max(movies.count, 1)
    }

    func update(movies: [MovieRepresentable]) {
        self.movies = movies
    }

    var isFetchingData: Bool = false {
        didSet {
            isFetchingDataHandler?(isFetchingData)
        }
    }
    var noMoviesToDisplay: Bool { movies.count == 0 }

    var noMoviesToDisplayInformationString: String {
        return "Welcome to WatchBox\n\nPlease user the search bar above to search for your favourite movies. All the moviews that you favourite will be displayed here."
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
