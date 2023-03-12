//
//  Persistence.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext
          .automaticallyMergesChangesFromParent = true
    }
}

/**
 let newContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
 
 let fetchSong = NSFetchRequest<Song>(entityName: "Song")
 or
 let fetchSong = Song.fetchRequest()
 let predicate = NSPredicate(format: "name = %@", "Time")
 fetchSong.predicate = predicate
 
 //SORTING
 let dataSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
 fetchSong.sortDescriptors = [dataSortDescriptor]
 
 let songs = try context.fetch(fetchSong)
 
 If we don't have an NSMangedObject sublass, we can pass NSFetchRequestResult and cast the result later.
 i.e.
 let fetchSong = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
 
 
 */
