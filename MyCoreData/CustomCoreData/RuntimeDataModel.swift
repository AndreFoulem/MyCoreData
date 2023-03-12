//
//  RuntimeDataModel.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import Foundation
import CoreData

class test {
  let model = NSManagedObjectModel()
  
  let entityAlbum = NSEntityDescription()
  entityAlbum.name = "Album"
  entityAlbum.managedObjectClassName = "Album"
  
  let titleAttribute = NSAttributeDescription()
  titleAttribute.name = "Title"
  titleAttribute.attributeType = .stringAttributeType
  
  let properties = [titleAttribute]
  
  entityAlbum.properties = properties
  
  model.entities = [entityAlbum]
  
   
}
