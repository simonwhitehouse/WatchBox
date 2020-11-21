//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import Foundation

import WBData

public enum MovieServiceError: Error {
    case invalidRequest
    case noInternetConnection
    case unknownError
    case invalidResponse
}

public protocol MovieServiceProviding {

    func fetchMovies(with searchTerm: String, plotType: PlotLength, completion: @escaping ((Result<Movie, MovieServiceError>) -> Void)) -> URLSessionTask?
}

public struct MovieService: MovieServiceProviding {

    private let urlSession: URLSession

    private struct Constants {
        static let baseURL = "http://www.omdbapi.com/"
        static let plotQueryParam = "plot"
        static let apiKeyParam = "apikey"
        static let apiKey = "ba4ce449" // really dont like this being in plain text here. Would ideally have this retrieve from our API or would be retreiving by a login call ect when used in a proper system. Another option would be to read this value from a configuration file.
        static let searchTermKey = "t"
    }

    public init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
    }

    public func fetchMovies(with searchTerm: String, plotType: PlotLength = .short, completion: @escaping ((Result<Movie, MovieServiceError>) -> Void)) -> URLSessionTask? {
        // Instead here we could instead force unwrap the URL as we know for sure it should be valid URL and not return nil.
        // But generally i like to not use force unwraps unless really required.
        guard let url = URL(string: Constants.baseURL
                                + "?\(Constants.apiKeyParam)=\(Constants.apiKey)"
                                + "&\(Constants.searchTermKey)=\(searchTerm)"
                                + "&\(Constants.plotQueryParam)=\(plotType.rawValue))") else {
            completion(.failure(.unknownError))
            return nil
        }

        let urlRequest = URLRequest(url: url)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                // TODO: Parse error here
                completion(.failure(.invalidRequest))
            }

            if let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                completion(.success(movie))
            } else {
                completion(.failure(.invalidResponse))
            }
        }

        dataTask.resume()
        return dataTask
    }
}
