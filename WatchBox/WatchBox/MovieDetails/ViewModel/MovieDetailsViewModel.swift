//
//  MovieDetailsViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import WBData
import WBPersistenceStore

public class MovieDetailsViewModel {

    var movie: MovieRepresentable
    private let favouritesManager: FavouritesManager

    public init(movie: MovieRepresentable, favouritesManager: FavouritesManager = FavouritesManager.default) {
        self.movie = movie
        self.favouritesManager = favouritesManager
    }

    public var title: String {
        return movie.title ?? ""
    }

    public var isFavourite: Bool {
        return movie.isFavourite
    }

    public var plot: String {
        return movie.plot ?? ""
    }

    public var actors: String? {
        return movie.actors ?? ""
    }

    public var usersRating: Int16 {
        return movie.usersRating
    }

    public func toggleFavourite(isFavourite: Bool) {
        favouritesManager.update(movie: movie, isFavourite: !isFavourite)
    }

    public func updateRating(_ rating: Int16) {
        favouritesManager.update(rating: rating, for: movie)
    }
}
