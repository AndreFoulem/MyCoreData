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
    do {
        //-> Add a persistent store type to the coordinator
      try persistentStoreCoordinator2.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil)
    } catch {
      fatalError("Unable to Add In-Memomry store to my ")
    }
    
    return persistentStoreCoordinator2
  }()
  
  
  
  
}
