//
//  LSCoreDataStack+Extensions.swift
//  LDExample
//
//  Created by Dino Gustin on 25.03.2022..
//

import LSCocoa

extension LSCoreDataStack {
    static let shared: LSCoreDataStack = {
        do {
            return try LSCoreDataStack(modelName: "Model")
        } catch let error {
            fatalError("Unable to create CoreData stack")
        }
    }()
}
extension LSCoreDataRepository {
    convenience init() {
        self.init(stack: LSCoreDataStack.shared)
    }
}
