//
//  FavouritesManager.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import Foundation

import WBData

public class FavouritesManager {
    private let storage: Storage
    public static let `default` = FavouritesManager()

    init(storage: Storage = Storage()) {
        self.storage = storage
    }

    public func fetchFavourites() -> [Movie] {
        return storage.fetchMovies()
    }

    public func update(movie: Movie, isFavourite: Bool) {
        if isFavourite {
            storage.add(favourite: movie)
        } else {
            storage.remove(movie: movie)
        }
    }

    public func updateRating(for movie: Movie) {
        storage.update(movie: movie)
    }

    public func isMovieAFavourite(movie: Movie) -> Bool {
        let movies = fetchFavourites()
        return movies.contains(movie)
    }

    public func clear() {
        storage.clear()
    }
}

// This could be resplaced with anything really, core data ect.
// For quickness and ease of use just going to user UserDefaults
class Storage {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func fetchMovies() -> [Movie] {
        if let data = userDefaults.object(forKey: "favourites") as? Data {
            return (try? JSONDecoder().decode([Movie].self, from: data)) ?? []
        } else {
            return []
        }
    }

    func add(favourite: Movie) {
        var exsistingMovies = Set(fetchMovies())
        exsistingMovies.insert(favourite)
        save(movies: Array(exsistingMovies))
    }

    func remove(movie: Movie) {
        var exsistingMovies = Set(fetchMovies())
        exsistingMovies.remove(movie)
        save(movies: Array(exsistingMovies))
    }

    func update(movie: Movie) {
        remove(movie: movie)
        add(favourite: movie)
    }

    private func save(movies: [Movie]) {
        if let data = try? JSONEncoder().encode(movies) {
            userDefaults.setValue(data, forKey: "favourites")
        }
    }

    func clear() {
        save(movies: [])
    }
}


public extension Movie {
    var isFavourite: Bool {
        FavouritesManager.default.isMovieAFavourite(movie: self)
    }
}
