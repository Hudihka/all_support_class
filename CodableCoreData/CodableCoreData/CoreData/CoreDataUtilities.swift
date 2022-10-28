//
//  CoreDataUtilities.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 18.10.2021.
//

import Foundation
import CoreData

class CoreDataUtilities<T: NSManagedObject> {

    //MARK: - поиск всех
    static func getAllObject(
        context: NSManagedObjectContext? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) -> [T] {
        guard let ctx = context ?? defaultContext else {return []}

        var objects: [T]?
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.className)
            fetchRequest.sortDescriptors = sortDescriptors
            fetchRequest.predicate = predicate
            try objects = ctx.fetch(fetchRequest) as? [T]
        } catch {
            print(error)
        }

        return objects ?? []
    }

    static func getAllObject(
        context: NSManagedObjectContext? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        predicateCompound: NSCompoundPredicate? = nil
    ) -> [T] {
        guard let ctx = context ?? defaultContext else {return []}

        var objects: [T]?
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.className)
            fetchRequest.sortDescriptors = sortDescriptors
            fetchRequest.predicate = predicateCompound
            try objects = ctx.fetch(fetchRequest) as? [T]
        } catch {
            print(error)
        }

        return objects ?? []
    }

    static func deleteObject(
        context: NSManagedObjectContext? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) {
        guard let ctx = context ?? defaultContext else { return }

        let objects = getAllObject(
            context: ctx,
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )

        objects.forEach { ctx.delete($0) }
    }

    static func deleteObject(
        context: NSManagedObjectContext? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        predicateCompound: NSCompoundPredicate? = nil
    ) {
        guard let ctx = context ?? defaultContext else { return }

        let objects = getAllObject(
            context: ctx,
            sortDescriptors: sortDescriptors,
            predicateCompound: predicateCompound
        )

        objects.forEach { ctx.delete($0) }
    }
}
