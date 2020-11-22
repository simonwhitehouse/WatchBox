//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import CoreData

import WBData

// This could be resplaced with anything really, basic userdefaults. See previous commits when had it implemented in simple user default model.
public class Storage {

    private lazy var persistentContainer: NSPersistentContainer = {
        guard
            let modelURL = Bundle.module.url(forResource:"MovieDatabase", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Cant load without data model")
            // here we would try and add some migration process
        }
        let container = NSPersistentContainer(name:"MovieDatabase", managedObjectModel:model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public static let shared = Storage()

    func fetchMovies(filterFavourites: Bool) -> [MovieRepresentable] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()

        if filterFavourites {
            request.predicate = NSPredicate(format: "isFavourite == TRUE")
        }

        do {
            return try context.fetch(request) as [MovieRepresentable]
        } catch {
            return []
        }
    }

    func add(favourite: MovieRepresentable) {
        if let movie = favourite as? Movie {
            movie.isFavourite = true
            try? movie.managedObjectContext?.save()
        }
    }

    func remove(movie: MovieRepresentable) {
        if let movie = movie as? Movie {
            movie.isFavourite = false
            try? movie.managedObjectContext?.save()
        }
    }

    func update(rating: Int16, for movie: MovieRepresentable) {
        if let movie = movie as? Movie {
            movie.usersRating = rating
            try? movie.managedObjectContext?.save()
        }
    }

    func clear() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch {
            // Handle error here
        }
    }
}
