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
 
 ** fetchOffset
 ** fetchLimit
 ** includePendingChanges: false
 
 ** objectID: NSManagedObjectID
 let newSong = try context.existingObject(with: ObjectID)
 
 ** Predefined Fetch Request
 let fetchRequest = persistentContainer.managedObjectModel.fetchRequestTemplate(forName: "allAlbumRequest")
 
 ** OPTOMISTIC LOCKING **
 
 ** When we fetch and object from a context, Core Data takes a snapshot of the object data from the persistent store, including its to-one relationship **  When to user save the context, the context looks if the snapshot is different from snapshot2.
 
 ** NSErrorMergePolicy = OPTOMISTIC LOCKING
   .mergeByPropertyStoreTrump   // Trump the store
 
    .mergeByPropertyObjectTrump  // Trump the object
 
    .overwrite  // FORCE ALL EX: User changes obj title, store title and body is changed with server service. .overwrite will trump all off store properties with obj properties.
 
    .rollback // inverso of .overwrite.  Ditches all changes made from objects.
 
 
 
 
 */
