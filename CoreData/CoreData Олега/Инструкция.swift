//
//  Инструкция.swift
//  testDelegste
//
//  Created by Hudihka on 16/06/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

//


/*для начала нужно установить мапер*/

pod 'ObjectMapper', '~> 3.3'

/*далее импортируем в проект CoreDataManager и CoreDataUtils
 создаем кор дату
 важно что бы у первой сущности с которой начинался процес парсинга было поле id Int32

 За место DefaultsUtils.currentAccount()?.id добавляете свою проверку, которая проверяет есть ли в памяти в данный момент модель с каким либо id

инициализируем модели

если в проекте есть модели без поля ид то в файл CoreDataUtils добавляем сл расширение
 */

protocol NSManagedObjectNoId where Self: NSManagedObject {
}

extension NSManagedObjectNoId where Self: Mappable {
    @discardableResult static func findCreate(json: [String: Any], context: NSManagedObjectContext? = nil) -> Self? {
        guard let ctx = context ?? currentContext() else {
            return nil
        }

        if let descr = NSEntityDescription.entity(forEntityName: entityName(), in: ctx),
            var obj = NSManagedObject(entity: descr, insertInto: ctx) as? Self {
            obj.mapping(map: Map(mappingType: .fromJSON, JSON: json))
            return obj
        }
        fatalError("No entity for \(entityName())")
    }

    init?(map: Map) {
        fatalError("Use findCreate")
    }
}

/* далее по примеру, например модель TimeIntervalCD не содержит поле ID но тк от модели SalleCD
 идет к ней связь то нужен трансформ

 Поля же меню и полныйХолодильник содержат
 */

/*Настройка апп делегатта*/

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    CoreDataManager.shared.initialize() //не сработает если нет аккаунта
    return true
}

func applicationDidEnterBackground(_ application: UIApplication) {
    CoreDataManager.shared.save()
}

func applicationWillTerminate(_ application: UIApplication) {
    CoreDataManager.shared.save()
}


/*собственно начало работы с кор датой когда только получили аккаунт*/

let strId = String(format: "%d", account.id) //account.id собственно ид акаунта что придет
CoreDataManager.shared.changeContext(for: strId)

DefaultsUtils.save(account: account)
DefaultsUtils.set(currentAccount: account)
DefaultsUtils.set(sessionID: sessionId)

/*когда выходим из аккаунта*/

CoreDataManager.shared.changeContext(for: nil)
DefaultsUtils.deleteAccountAndSession()
