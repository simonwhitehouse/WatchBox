//
//  Entity+CoreDataClass.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 22/11/2020.
//
//

import Foundation
import CoreData

import WBData

enum MovieDecodingError: Error {
    case missingContext
    case missingRequiredInformation
}

public class Movie: NSManagedObject, Decodable, MovieRepresentable {

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runTime = "Runtime"
        case plot = "Plot"
        case posterURL = "Poster"
        case actors = "Actors"
        case id = "imdbID"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw MovieDecodingError.missingContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.year = try container.decodeIfPresent(String.self, forKey: .year)
        self.rated = try container.decodeIfPresent(String.self, forKey: .rated)
        self.released = try container.decodeIfPresent(String.self, forKey: .released)
        self.runTime = try container.decodeIfPresent(String.self, forKey: .runTime)
        self.plot = try container.decodeIfPresent(String.self, forKey: .plot)
        self.posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.actors = try container.decodeIfPresent(String.self, forKey: .actors)

        // FIX
        self.usersRating = 0
        self.isFavourite = false

        guard self.title != nil, self.year != nil, self.plot != nil else {
            self.managedObjectContext?.delete(self)
            throw MovieDecodingError.missingRequiredInformation
        }
        try? managedObjectContext?.save()
    }
}

public extension Movie {

    static func fetchMovie(with data: Data, in context: NSManagedObjectContext) -> Movie? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: AnyHashable],
              let title = json[Movie.CodingKeys.title.rawValue] as? String,
              let year = json[Movie.CodingKeys.year.rawValue] as? String,
              json[Movie.CodingKeys.plot.rawValue] != nil else {
            return nil
        }
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND year == %@", title, year)

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            return nil
        }
    }

    func update(with data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: String] else { return }

        self.title = json[Movie.CodingKeys.title.rawValue]
        self.plot = json[Movie.CodingKeys.plot.rawValue]
        self.year = json[Movie.CodingKeys.year.rawValue]
        self.rated = json[Movie.CodingKeys.rated.rawValue]
        self.released = json[Movie.CodingKeys.released.rawValue]
        self.runTime = json[Movie.CodingKeys.runTime.rawValue]
        self.posterURL = json[Movie.CodingKeys.posterURL.rawValue]
        self.id = json[Movie.CodingKeys.id.rawValue]
        self.actors = json[Movie.CodingKeys.actors.rawValue]
        try? managedObjectContext?.save()
    }
}
