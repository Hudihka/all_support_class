//
//  CoreDataManager.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 18.10.2021.
//

import Foundation
import UIKit
import CoreData

var defaultContext: NSManagedObjectContext? {
    return CoreDataManager.shared.managedObjectContext
}

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()

    private(set) var managedObjectContext: NSManagedObjectContext?

    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func initialize() {
        managedObjectContext = nil
        managedObjectContext = self.persistentContainer.viewContext
    }

    public func clearAllCoreData() {
        let entities = self.persistentContainer.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(_ entity: String) {
        let context = self.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error {
            print("ошибка при удалении всех проперти кор даты")
            print(error)
        }
    }
}


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")
}

/*
 func deleteAll(ctx: NSManagedObjectContext?, type: NSManagedObject.Type){

     guard let ctx = ctx ?? defaultContext else {
         return
     }

     let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: type.className)
     let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

     do {
         try ctx.execute(deleteRequest)
     } catch let error {
         print("-----------------------------")
         print(error)
         print("-----------------------------")
     }
 }
 */
