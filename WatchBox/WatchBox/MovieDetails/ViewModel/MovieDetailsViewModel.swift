//
//  MovieDetailsViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import WBData
import WBPersistenceStore

public class MovieDetailsViewModel {

    var movie: Movie
    private let favouritesManager: FavouritesManager

    public init(movie: Movie, favouritesManager: FavouritesManager = FavouritesManager.default) {
        self.movie = movie
        self.favouritesManager = favouritesManager
    }

    public var title: String {
        return movie.title
    }

    public var isFavourite: Bool {
        return movie.isFavourite
    }

    public var plot: String {
        return movie.plot
    }

    public var actors: String? {
        return movie.actors
    }

    public var usersRating: Int {
        return movie.usersRating ?? 0
    }

    public func toggleFavourite(isFavourite: Bool) {
        favouritesManager.update(movie: movie, isFavourite: !isFavourite)
    }

    public func updateRating(_ rating: Int) {
        movie.usersRating = rating
        favouritesManager.updateRating(for: movie)
    }
}
