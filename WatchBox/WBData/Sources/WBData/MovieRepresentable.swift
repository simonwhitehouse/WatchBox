//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import Foundation

public enum PlotLength: String {
    case full
    case short
}

extension CodingUserInfoKey {
    public static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

public protocol MovieRepresentable {
    var title: String? { get }
    var year: String? { get }
    var rated: String? { get }
    var released: String? { get }
    var runTime: String? { get }
    var plot: String? { get }
    var posterURL: String? { get }
    var actors: String? { get }
    var id: String? { get }
    var usersRating: Int16 { get }
    var isFavourite: Bool { get }
}
