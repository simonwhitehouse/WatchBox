//
//  FavouritesManager.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import Foundation
import CoreData

import WBData

public class FavouritesManager {
    private let storage: Storage
    public static let `default` = FavouritesManager()

    init(storage: Storage = Storage.shared) {
        self.storage = storage
    }

    public func fetchFavourites() -> [MovieRepresentable] {
        return storage.fetchMovies(filterFavourites: true)
    }

    public func update(movie: MovieRepresentable, isFavourite: Bool) {
        if isFavourite {
            storage.add(favourite: movie)
        } else {
            storage.remove(movie: movie)
        }
    }

    public func update(rating: Int16, for movie: MovieRepresentable) {
        storage.update(rating: rating, for: movie)
    }

    public func clear() {
        storage.clear()
    }
}
