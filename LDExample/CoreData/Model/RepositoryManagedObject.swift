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
class RepositoryManagedObject: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var stars: NSNumber
    @NSManaged public var watchers: NSNumber
    @NSManaged public var owner: OwnerManagedObject
}

extension RepositoryManagedObject: LSManagedObject {
    
    func populate(with model: Repository, in context: NSManagedObjectContext?) {
        name = model.name
        id = model.id
    }
    
    func toModel() -> Repository {
        Repository(id: id, name: name, watchers: watchers.intValue, stars: stars.intValue, owner: owner.toModel())
    }
    
    typealias T = RepositoryManagedObject
    
    typealias AppModel = Repository
}

extension Repository: LSManagedObjectConvertible {
    typealias ManagedObject = RepositoryManagedObject
}
