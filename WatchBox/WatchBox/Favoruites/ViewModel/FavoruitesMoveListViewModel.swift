//
//  FavoruitesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import Foundation

import WBData
import WBPersistenceStore
import WBNetworking

public class FavoruitesMoveListViewModel: FilmListViewModel {

    public let searchFilmsViewModel: SearchFilmsViewModel

    public init(searchFilmsViewModel: SearchFilmsViewModel = SearchFilmsViewModel()) {
        self.searchFilmsViewModel = searchFilmsViewModel
    }

    public func fetchFavourites(completion: ((_ movies: [Movie]) -> Void)) {
        let favourites = FavoruitesManager.default.fetchFavourites()
        self.update(movies: favourites)
        completion(favourites)
    }
}
