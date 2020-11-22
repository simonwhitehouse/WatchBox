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

//    enum CodingKeys: String, CodingKey {
//        case title = "Title"
//        case year = "Year"
//        case rated = "Rated"
//        case released = "Released"
//        case runTime = "Runtime"
//        case plot = "Plot"
//        case posterURL = "Poster"
//        case actors = "Actors"
//        case id = "imdbID"
//    }
}

/*{
 \"Title\":\"It\",
 \"Year\":\"2017\",
 \"Rated\":\"R\",
 \"Released\": \"08 Sep 2017\",
 \"Runtime\":\"135 min\",
 \"Genre\":\"Horror\",
 \"Director\":\"Andy Muschietti\",
 \"Writer\":\"Chase Palmer (screenplay by), Cary Joji Fukunaga (screenplay by), Gary Dauberman (screenplay by), Stephen King (based on the novel by)\",\"Actors\":\"Jaeden Martell, Jeremy Ray Taylor, Sophia Lillis, Finn Wolfhard\",
 \"Plot\":\"In the summer of 1989, a group of bullied kids band together to destroy a shape-shifting monster, which disguises itself as a clown and preys on the children of Derry, their small Maine town.\",
 \"Language\":\"English, Hebrew\",
 \"Country\":\"Canada, USA\",
 \"Awards\":\"8 wins & 49 nominations.\",
 \"Poster\":\"https://m.media-amazon.com/images/M/MV5BZDVkZmI0YzAtNzdjYi00ZjhhLWE1ODEtMWMzMWMzNDA0NmQ4XkEyXkFqcGdeQXVyNzYzODM3Mzg@._V1_SX300.jpg\",
 \"Ratings\":[{\"Source\":\"Internet Movie Database\",\"Value\":\"7.3/10\"},{\"Source\":\"Rotten Tomatoes\",\"Value\":\"85%\"},{\"Source\":\"Metacritic\",\"Value\":\"69/100\"}],\"Metascore\":\"69\",\"imdbRating\":\"7.3\",\"imdbVotes\":\"450,627\",\"imdbID\":\"tt1396484\",\"Type\":\"movie\",\"DVD\":\"N/A\",\"BoxOffice\":\"N/A\",\"Production\":\"Vertigo Entertainment, RatPac-Dune Entertainment, Lin Pictures\",\"Website\":\"N/A\",\"Response\":\"True\"}"**/
