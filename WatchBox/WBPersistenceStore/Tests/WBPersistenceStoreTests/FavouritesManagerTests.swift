//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import XCTest
@testable import WBPersistenceStore
@testable import WBData

final class FavouritesManagerTests: XCTestCase {

    func testFavouritesManagerFetchMovies() {
        let favouritesManager = FavouritesManager(storage: MockedStorage())
        XCTAssertEqual(favouritesManager.fetchFavourites().count, 0)


        let favourite = MockedMovieRepresentable(title: "Test fave 1", usersRating: 1, isFavourite: true)
        favouritesManager.update(movie: favourite, isFavourite: true)

        XCTAssertEqual(favouritesManager.fetchFavourites().count, 1)

        let favourite2 = MockedMovieRepresentable(title: "Test none 2", usersRating: 1, isFavourite: false)
        favouritesManager.update(movie: favourite2, isFavourite: true)

        XCTAssertEqual(favouritesManager.fetchFavourites().count, 1)

        // Unfavoruite movie
        favouritesManager.update(movie: favourite, isFavourite: false)
        XCTAssertEqual(favouritesManager.fetchFavourites().count, 0)
    }

    func testFavouritesManagerClear() {
        let favouritesManager = FavouritesManager(storage: MockedStorage())
        XCTAssertEqual(favouritesManager.fetchFavourites().count, 0)

        let favourite = MockedMovieRepresentable(title: "Test fave 1", usersRating: 1, isFavourite: true)
        favouritesManager.update(movie: favourite, isFavourite: true)

        // Precondition check
        XCTAssertEqual(favouritesManager.fetchFavourites().count, 1)

        favouritesManager.clear()
        XCTAssertEqual(favouritesManager.fetchFavourites().count, 0)
    }
    
}

struct MockedMovieRepresentable: MovieRepresentable, Codable, Hashable {
    var title: String?
    var year: String?
    var rated: String?
    var released: String?
    var runTime: String?
    var plot: String?
    var posterURL: String?
    var actors: String?
    var id: String?
    var usersRating: Int16
    var isFavourite: Bool
}

final class MockedStorage: StorageProviding {

    var userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func fetchMovies(filterFavourites: Bool) -> [MovieRepresentable] {
        if let data = userDefaults.object(forKey: "favourites") as? Data {
            let fetchedMovies = (try? JSONDecoder().decode([MockedMovieRepresentable].self, from: data)) ?? []
            return fetchedMovies.filter { $0.isFavourite }
        } else {
            return []
        }
    }

    func add(favourite: MovieRepresentable) {
        if let favourites = fetchMovies(filterFavourites: true) as? [MockedMovieRepresentable], let favourite = favourite as? MockedMovieRepresentable {
            var exsistingMovies = Set(favourites)
            exsistingMovies.insert(favourite)
            save(movies: Array(exsistingMovies))
        }
    }

    func remove(movie: MovieRepresentable) {
        if let favourites = fetchMovies(filterFavourites: true) as? [MockedMovieRepresentable], let movie = movie as? MockedMovieRepresentable {
            var exsistingMovies = Set(favourites)
            exsistingMovies.remove(movie)
            save(movies: Array(exsistingMovies))
        }
    }

    func update(rating: Int16, for movie: MovieRepresentable) {
        // TODO
    }

    func clear() {
        save(movies: [])
    }

    private func save(movies: [MovieRepresentable]) {
        if let movies = movies as? [MockedMovieRepresentable] {
            if let data = try? JSONEncoder().encode(movies) {
                userDefaults.setValue(data, forKey: "favourites")
            }
        }
    }
}
