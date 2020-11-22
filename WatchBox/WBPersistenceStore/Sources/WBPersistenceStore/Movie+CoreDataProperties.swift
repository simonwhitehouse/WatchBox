//
//  Movie+CoreDataProperties.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 22/11/2020.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var actors: String?
    @NSManaged public var id: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var plot: String?
    @NSManaged public var posterURL: String?
    @NSManaged public var rated: String?
    @NSManaged public var released: String?
    @NSManaged public var runTime: String?
    @NSManaged public var title: String?
    @NSManaged public var usersRating: Int16
    @NSManaged public var year: String?
}
