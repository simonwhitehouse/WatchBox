//
//  MovieDetailsViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import WBData

public class MovieDetailsViewModel {

    let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
    }

    public var title: String {
        return movie.title
    }
}
