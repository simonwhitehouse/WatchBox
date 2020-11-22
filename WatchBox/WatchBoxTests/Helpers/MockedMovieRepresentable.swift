//
//  MockedMovieRepresentable.swift
//  WatchBoxTests
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import XCTest
@testable import WBData

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
