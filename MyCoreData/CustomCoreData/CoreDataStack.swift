//
//  CoreDataStack.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import CoreData

final class CoreDataStack {
  
  //--------------------------------------//
  //----- A || MANAGED OBJECT MODEL ------//
  //--------------------------------------//
  private lazy var managedObjectModel: NSManagedObjectModel = {
    
    guard let url = Bundle.main.url(forResource: "MyModel", withExtension: "momd") else {
      fatalError("Unable to find file Data Model")
    }
    
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Unable to initiate the NSManagedObjectModel with the file")
    }
    
    return managedObjectModel
  }() // inititate a NSManagedObjectModel with IFEE closure
  
  
  //--------------------------------------//
  //----- B -- IN-MEMORY -- || PERSISTENT STORE COORDINATOR ------//
  //--------------------------------------//
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    
    //-> Initiate a persistentStoreCoordinator with a reference to the MOM
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    do {
      //-> Add a persistent store type to the coordinator
      try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil)
    } catch {
      fatalError("Unable to Add In-Memomry store to my ")
    }
    
    return persistentStoreCoordinator
  }()
  
    //--------------------------------------//
    //----- B -- SQL LITE -- || PERSISTENT STORE COORDINATOR ------//
    //--------------------------------------//
  private lazy var persistentStoreCoordinator2: NSPersistentStoreCoordinator = {
    
    //-> Initiate a persistentStoreCoordinator with a reference to the MOM
    let persistentStoreCoordinator2 = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    //-> Pass the path to the SQLite file
    let fileManager = FileManager.default
    let storeName = "MyStorage.sqlite"
    let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
    
    do {
      let options = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
      ]
      
        //-> Add a persistent store type to the coordinator
      try persistentStoreCoordinator2.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
    } catch {
      fatalError("Unable to Add In-Memomry store to my ")
    }
    
    return persistentStoreCoordinator2
  }()
  
    //--------------------------------------//
    //----- C -- MANAGED OBJECT CONTEXT ------//
    //--------------------------------------//
  lazy var managedObjectContext: NSManagedObjectContext = {
    //-> Initialize the MOC
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    //-> Add a reference to the PSC
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    
    return managedObjectContext
    
  }()

//  let context = persistentContainer.viewContext
//  let privateContext = persistentContainer.newBackgroundContext()
  
    /**
     Instead of
     let container = NSPersistentContainer(name: "MyStore")
     
     WE CAN DO
     [A]
     var objectModel: NSManagedObjectModel =  {
        guard let url = Bundle.main.url(forResource: "MyModel", withExtension: "momd") else {
            fatal
        }
     
       guard let managedObjectModel = NSManagedObjectModel(contentOf: url) else {
            fatal
        }
        return managedObjectModel
     }
     
     func persistentContainer () {
        let container = NSPersistendContainer(name: "mysqlFile", managedObjectModel: objectModel)
     }
     
     let container = NSPersistentContainer(name: "mysqlFile")
     [B]
     let storeType = NSPersistentStoreDescription()
     storeType.type = NSInMemoryStoreType
     container.persistentStoreDescriptions = [storeType]
     
     
     */
  /**
   NSEntityDescription
   .entitiesByName["name"]
   NSRelationshipDescription
   .relationshipsByName["composer"]
   
   let song = NSEntityDescription.insertNewObject(forEntityName: "Song", into: content)
   let composer = NSEntityDescription.insertNewObject(forEntityName: "Composer", into: context)
   song.setValue(composer, forKey: "composer")
   
   */
  
  
}
