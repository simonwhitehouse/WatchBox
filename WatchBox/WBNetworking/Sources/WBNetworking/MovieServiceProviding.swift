//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

import WBData
import WBPersistenceStore

public enum MovieServiceError: Error {
    case invalidRequest
    case noInternetConnection
    case unknownError
    case invalidResponse
    case noResults // Movie not found
}

public protocol MovieServiceProviding {

    func fetchMovies(with searchTerm: String, plotType: PlotLength, completion: @escaping ((Result<Movie, MovieServiceError>) -> Void)) -> URLSessionTask?

    func fetchMoviePoster(for movie: Movie, useCache: Bool, completion: @escaping ((Result<UIImage, MovieServiceError>) -> Void)) -> URLSessionTask?
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


        var urlComponents = URLComponents(string: Constants.baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.apiKeyParam, value: Constants.apiKey),
            URLQueryItem(name: Constants.searchTermKey, value: searchTerm),
            URLQueryItem(name: Constants.plotQueryParam, value: plotType.rawValue)
        ]

        // Instead here we could instead force unwrap the URL as we know for sure it should be valid URL and not return nil.
        // But generally i like to not use force unwraps unless really required.
        guard let url = urlComponents?.url else {
            completion(.failure(.unknownError))
            return nil
        }

        let urlRequest = URLRequest(url: url)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    // TODO: Parse error here
                    completion(.failure(.invalidRequest))
                    return
                }

                if let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                    print(String(data: data, encoding: .utf8))
                    completion(.success(movie))
                } else {
                    completion(.failure(.invalidResponse))
                }
            }
        }

        dataTask.resume()
        return dataTask
    }

    public func fetchMoviePoster(for movie: Movie, useCache: Bool = true, completion: @escaping ((Result<UIImage, MovieServiceError>) -> Void)) -> URLSessionTask? {
        guard let postURLString = movie.posterURL, let url = URL(string: postURLString) else {
            completion(.failure(.unknownError))
            // TODO: Parse error here
            return nil
        }

        if useCache, let cachedImage = ImageStore.shared.image(for: NSString(string: postURLString)) {
            completion(.success(cachedImage))
            return nil
        } else {
            let downloadTask = urlSession.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        // TODO: Parse error here
                        completion(.failure(.invalidResponse))
                        return
                    }

                    guard let data = data, (response?.mimeType?.hasPrefix("image") ?? false), let image = UIImage(data: data) else {
                        completion(.failure(.invalidResponse))
                        return
                    }

                    ImageStore.shared.store(image: image, for: NSString(string: postURLString))
                    completion(.success(image))
                }
            }

            downloadTask.resume()
            return downloadTask
        }
    }

}
