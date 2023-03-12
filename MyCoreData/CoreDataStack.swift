//
//  CoreDataStack.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import CoreData

final class CoreDataStack {
  
  // A || MANAGED OBJECT MODEL
  
  private lazy var managedObjectModel: NSManagedObjectModel = {
    
    guard let url = Bundle.main.url(forResource: "MyModel", withExtension: "momd") else {
      fatalError("Unable to find file Data Model")
    }
    
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Unable to initiate the NSManagedObjectModel with the file")
    }
    
    return managedObjectModel
  }() // inititate a NSManagedObjectModel with IFEE closure
  
  
}
