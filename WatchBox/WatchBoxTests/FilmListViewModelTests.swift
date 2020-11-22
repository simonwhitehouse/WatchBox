//
//  WatchBoxTests.swift
//  WatchBoxTests
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import XCTest
@testable import WatchBox
@testable import WBNetworking
@testable import WBData
@testable import WBPersistenceStore

class FilmListViewModelTests: XCTestCase {

    private func initiliseViewModelWithDefaultState() -> FilmListViewModel {
        let viewModel = FilmListViewModel(movieServiceProviding: MockedMovieService())

        XCTAssertFalse(viewModel.isFetchingData)
        XCTAssertEqual(viewModel.numberOfRowsToDisplay, 1)
        XCTAssertTrue(viewModel.noMoviesToDisplay)
        XCTAssertEqual(viewModel.noMoviesToDisplayInformationString, "Welcome to WatchBox\n\nPlease user the search bar above to search for your favourite movies. All the moviews that you favourite will be displayed here.")
        XCTAssertNil(viewModel.movie(at: 0))
        return viewModel
    }

    func testFilmListViewModelAddMockedMovieState() {
        let viewModel = initiliseViewModelWithDefaultState()
        let testUUID = UUID().uuidString
        let favourite = MockedMovieRepresentable(title: "Test fave 1", id: testUUID, usersRating: 1, isFavourite: true)

        viewModel.update(movies: [favourite])
        XCTAssertEqual(viewModel.numberOfRowsToDisplay, 1)
        XCTAssertFalse(viewModel.noMoviesToDisplay)
        XCTAssertEqual(viewModel.movie(at: 0)?.id, favourite.id)
    }

    func testFilmListViewModelSelectMovie() {
        let viewModel = initiliseViewModelWithDefaultState()
        let expection = expectation(description: "Expecting selection handler to be called")
        let testUUID = UUID().uuidString
        let favourite = MockedMovieRepresentable(title: "Test fave 1", id: testUUID, usersRating: 1, isFavourite: true)

        viewModel.update(movies: [favourite])


        viewModel.movieSelectedHandler = { movie in
            XCTAssertEqual(movie.id, testUUID)
            expection.fulfill()
        }

        viewModel.select(movie: favourite)
        wait(for: [expection], timeout: 1)
    }

    func testFilmListViewModelisFetchingDataHandler() {
        let viewModel = initiliseViewModelWithDefaultState()
        let expection = expectation(description: "Expecting selection handler to be called")

        viewModel.isFetchingDataHandler = { _ in
            expection.fulfill()
        }

        viewModel.isFetchingData = true
        wait(for: [expection], timeout: 1)
    }
}

public struct MockedMovieService: MovieServiceProviding {

    public func fetchMovies(with searchTerm: String, plotType: PlotLength, completion: @escaping ((Result<Movie, MovieServiceError>) -> Void)) -> URLSessionTask? {
        return nil
    }

    public func fetchMoviePoster(for movie: MovieRepresentable, useCache: Bool, completion: @escaping ((Result<UIImage, MovieServiceError>) -> Void)) -> URLSessionTask? {
        return nil
    }
}
