//
//  OwnerManagedObject.swift
//  LDExample
//
//  Created by Dino Gustin on 25.03.2022..
//

import Foundation
import LSCocoa
import LSData
import CoreData

@objc(OwnerManagedObject)
class OwnerManagedObject: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
}

extension OwnerManagedObject: LSManagedObject {
    func populate(with model: Owner, in context: NSManagedObjectContext?) {
        name = model.name
        id = model.id
    }
    
    func toModel() -> Owner {
        Owner(id: id, name: name)
    }
    
    typealias T = OwnerManagedObject
    
    typealias AppModel = Owner
}

extension Owner: LSManagedObjectConvertible {
    typealias ManagedObject = OwnerManagedObject
}
