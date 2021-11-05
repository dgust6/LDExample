//
//  RepositoryManagedObject.swift
//  LDExample
//
//  Created by Dino Gustin on 04.11.2021..
//

import Foundation
import LSCocoa
import LSData
import CoreData

@objc(RepositoryManagedObject)
public class RepositoryManagedObject: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
}

extension RepositoryManagedObject: LSManagedObject {
    
    public static var entityName: String {
        "RepositoryManagedObject"
    }
    
    public static var identityName: String {
        "id"
    }
    
    public func create(from model: Repository) -> RepositoryManagedObject {
        let object = RepositoryManagedObject()
        return object
    }
    
    public func populate(with model: Repository, in context: NSManagedObjectContext?) {
        name = model.name
        id = model.id
    }
    
    public func toModel() -> Repository? {
        Repository(id: id, name: name, watchers: 0, stars: 0, owner: Owner(id: "", name: ""))
    }
    
    public typealias T = RepositoryManagedObject
    
    public typealias AppModel = Repository
}

extension Repository: LSManagedObjectConvertible {
    public typealias ManagedObject = RepositoryManagedObject
}
