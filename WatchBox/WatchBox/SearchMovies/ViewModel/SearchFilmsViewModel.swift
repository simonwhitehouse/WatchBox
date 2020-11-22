//
//  FavouritesMoveListViewModel.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//
import Foundation

import WBData
import WBPersistenceStore
import WBNetworking

public class SearchFilmsViewModel: FilmListViewModel {

    private var activeFetchRequest: URLSessionTask?
    private var activeSearchTerm: String?

    // Ideally would like to add some debouncing on here to ensure the API isnt bombarded with requests
    public func fetchMovies(with searchTerm: String?, plotType: PlotLength = .full, completion: @escaping ((_ movies: Movie?) -> Void)) {

        guard let searchTerm = searchTerm else {
            activeFetchRequest?.cancel()
            activeSearchTerm = nil
            update(movies: [])
            return
        }

        if activeFetchRequest != nil {
            self.activeFetchRequest?.cancel()
            self.activeSearchTerm = nil
        }

        let fetchMovieRequest = movieServiceProviding.fetchMovies(with: searchTerm, plotType: plotType) { [weak self] result in
            self?.activeSearchTerm = nil
            self?.activeFetchRequest = nil
            switch result {
            case .failure(_):
                self?.update(movies: [])
                completion(nil)
            case .success(let movie):
                self?.update(movies: [movie])
                completion(movie)
            }
        }

        activeFetchRequest = fetchMovieRequest
        activeSearchTerm = searchTerm
    }

}
