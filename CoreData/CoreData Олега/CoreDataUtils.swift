//
//  CoreDataUtils.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 19/01/2019.
//
//swiftlint:disable private_over_fileprivate

import Foundation
import CoreData
import ObjectMapper

protocol NSManagedObjectWithID where Self: NSManagedObject { //если это класс Mappable, то для него это расширение действует
    var id: Int32 { get set }                                //поэтому каждому классу КД где есть поле ID подписываем в наследие Mappable, NSManagedObjectWithID
}

extension NSManagedObjectWithID where Self: Mappable {
    /*https://medium.com/@marcosantadev/stored-properties-in-swift-extensions-615d4c5a9a58
     c помощью objc_getAssociatedObject и objc_setAssociatedObject можно задавать сохраненное свойство в расширение расширение*/

    var context: NSManagedObjectContext? { //расширение для прописываем свойства
        get { return objc_getAssociatedObject(self, &Constants.currentContext) as? NSManagedObjectContext } // Constants.currentContext должно быть статик
        set { objc_setAssociatedObject(self, &Constants.currentContext, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    static func find(by id: Int, context: NSManagedObjectContext? = nil) -> Self? { //получаем один обьект по id шнику
        guard let ctx = context ?? currentContext() else {  // currentContext() это CoreDataManager.shared.managedObjectContext
            return nil
        }

        let reqest = NSFetchRequest<Self>(entityName: entityName())
        reqest.predicate = NSPredicate(format: "id = %d", id)
        reqest.returnsObjectsAsFaults = false
        reqest.fetchLimit = 1                               //должен быть только один
        var objects: [Self]?
        do {
            objects = try ctx.fetch(reqest)
        } catch {
            fatalError(error.localizedDescription)
        }

        if let object = objects?.first {
            return object
        }
        return nil
    }

    //@discardableResult значит можем не использоваит возвращ значение

    @discardableResult static func findCreate(json: [String: Any], context: NSManagedObjectContext? = nil) -> Self? {  //основная функция, преобразует ДЖЕЙСОН в обьекты КД и сохраняет
        guard let ctx = context ?? currentContext() else {
            return nil
        }

        let idValue = json["id"]
        guard let id = Int(optional: (idValue as? Int32)) ?? (idValue as? Int) else {
            return nil                                                                      //если нет поля id то досвиданья
        }

        if var object = self.find(by: id, context: ctx) {                                   //если уже есть такой обьект по ID и мы его перезаписываем
            object.context = ctx                                                            //то у этого обьекта контекст наш нынешний контекст
            object.mapping(map: Map(mappingType: .fromJSON, JSON: json))                    //.mapping(map: эта функция которая прописывается в каждой моделе
            return object
        }

        if let descr = NSEntityDescription.entity(forEntityName: entityName(), in: ctx),    //описание сущности
            var obj = NSManagedObject(entity: descr, insertInto: ctx) as? Self {            //теперь создаем обьект по типу descr
            obj.context = ctx                                                               //ну и пошло поехало
            obj.mapping(map: Map(mappingType: .fromJSON, JSON: json))
            return obj
        }
        fatalError("No entity for \(entityName())")
    }

    init?(map: Map) {
        fatalError("Use findCreate")
    }
}

protocol NSManagedObjectExtension where Self: NSManagedObject {
}

extension NSManagedObject: NSManagedObjectExtension {
}

extension NSManagedObjectExtension where Self: NSManagedObject {
    static func entityName() -> String {
        return String(describing: self)
    }

    func entityName() -> String {
        return String(describing: type(of: self))
    }

    static func getAll(context: NSManagedObjectContext? = nil) -> [Self] {
        guard let ctx = context ?? currentContext() else {
            return []
        }

        let reqest = NSFetchRequest<Self>(entityName: entityName())
        reqest.returnsObjectsAsFaults = false  //не возвращать пустые сущности
        let object: [Self]?? = try? ctx.fetch(reqest)

        if let objects = object {
            return objects ?? []
        }
        return []
    }

    static func getAllBadge() -> [Self] { //выдает по 20 заказов отсортированных по номеру
        guard let ctx = currentContext() else {
            return []
        }

        let reqest = NSFetchRequest<Self>(entityName: entityName())
        reqest.returnsObjectsAsFaults = false
        reqest.fetchBatchSize = 20
        let sort = NSSortDescriptor(key: "id", ascending: false)
        reqest.sortDescriptors = [sort]
        let object: [Self]?? = try? ctx.fetch(reqest)

        if let objects = object {
            return objects ?? []
        }
        return []
    }
}

fileprivate enum Constants {
    static var currentContext: UInt8 = 0
}

class CoreDataTransform {
    var context: NSManagedObjectContext?

    init (context: NSManagedObjectContext? = nil) {
        self.context = context
    }
}
