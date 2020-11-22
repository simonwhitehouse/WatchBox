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
    public func fetchMovies(with searchTerm: String?, plotType: PlotLength = .full, completion: @escaping ((_ movies: Movie?, _ error: MovieServiceError?) -> Void)) {

        if activeSearchTerm == searchTerm {
            return
        }

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

        isFetchingData = true

        let fetchMovieRequest = movieServiceProviding.fetchMovies(with: searchTerm, plotType: plotType) { [weak self] result in
            self?.activeFetchRequest = nil
            self?.isFetchingData = false
            switch result {
            case .failure(let error):
                self?.update(movies: [])
                completion(nil, error)
            case .success(let movie):
                self?.update(movies: [movie])
                completion(movie, nil)
            }
        }

        activeFetchRequest = fetchMovieRequest
        activeSearchTerm = searchTerm
    }

    override var noMoviesToDisplayInformationString: String {
        if activeSearchTerm == nil {
            return super.noMoviesToDisplayInformationString
        } else {
            return "No movies matching the term: \"\(activeSearchTerm ?? "")\" found. Please try searching for a different movie."
        }
    }

}
