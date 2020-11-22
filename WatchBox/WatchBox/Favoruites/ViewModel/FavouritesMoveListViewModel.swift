//
//  FavouritesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import Foundation

import WBData
import WBPersistenceStore
import WBNetworking

public class FavouritesMoveListViewModel: FilmListViewModel {

    public let searchFilmsViewModel: SearchFilmsViewModel
    public let favouritesManager: FavouritesManager

    public init(
        searchFilmsViewModel: SearchFilmsViewModel = SearchFilmsViewModel(),
        favouritesManager: FavouritesManager = FavouritesManager.default
    ) {
        self.searchFilmsViewModel = searchFilmsViewModel
        self.favouritesManager = favouritesManager
    }

    public func fetchFavourites(completion: ((_ movies: [MovieRepresentable]) -> Void)) {
        let favourites = favouritesManager.fetchFavourites()
        self.update(movies: favourites)
        completion(favourites)
    }

    public func clearFavourites() {
        favouritesManager.clear()
    }
}
