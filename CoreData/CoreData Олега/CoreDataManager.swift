//
//  CoreDataManager.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 28/12/2018.
//
//swiftlint:disable force_unwrapping

import UIKit
import CoreData

func currentContext() -> NSManagedObjectContext? {
    return CoreDataManager.shared.managedObjectContext
}
class CoreDataManager: NSObject {
    static let shared = CoreDataManager()

    private var persistentStoreCoordinator: NSPersistentStoreCoordinator?  //Координатор, который использует модель, чтобы помочь контекстам и постоянным хранилищам общаться.

    private(set) var managedObjectContext: NSManagedObjectContext?

    private lazy var applicationDocumentsDirectory: NSURL = {             //как я понял получаем ссылку(адрес) на кор дату в дирректории
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  //получаем все обьектыд
        return urls[urls.count - 1] as NSURL
    }()

    private func createCoordinator(for ID: String) -> NSPersistentStoreCoordinator {
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!  //получаем адрес файла кор даты в проекте
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!           //получаем файл кор даты в проекте

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel) //получаем кординатор

        let url = self.applicationDocumentsDirectory.appendingPathComponent("CoreData_\(ID).sqlite") //создаем новый файл кор даты
        let failureReason = "There was an error creating or loading the application's saved data."

        let options: [AnyHashable: Any] = [
            NSSQLitePragmasOption: ["journal_mode": "DELETE"],
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9_999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }

    func initialize() {
        if let stringID = DefaultsUtils.currentAccount()?.id { //здесь идет получение акаута
            CoreDataManager.shared.changeContext(for: String(format: "%d", stringID))
        }
    }

    func save() {
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func changeContext(for ID: String?) {   //инициализируем контекстт
        try? managedObjectContext?.save()

        managedObjectContext = nil
        persistentStoreCoordinator = nil

        if let id = ID {
            persistentStoreCoordinator = createCoordinator(for: id)
            managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext?.persistentStoreCoordinator = persistentStoreCoordinator
        }
    }

    @objc @discardableResult func saveContext() -> Bool {
        guard let context = managedObjectContext else {
            return false
        }

        var sucess = true

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                sucess = false
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

        return sucess
    }
}
