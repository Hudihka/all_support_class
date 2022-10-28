//
//  Test.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 18.10.2021.
//
<<<<<<< HEAD
//
//import Foundation
//import CoreData
//
//@objc(User)

//public class Article: NSManagedObject, Decodable {
//    @NSManaged var title: String!
//    @NSManaged var summary: String?
//    @NSManaged var id: Int64
//
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case summary = "description"
//        case id
//    }
//
//    required convenience init(from decoder: Decoder) throws {

//
//        guard let contextUserInfoKey = CodingUserInfoKey.context else { fatalError("cannot find context key") }
//        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
//        guard let entity = NSEntityDescription.entity(forEntityName: Self.className, in: managedObjectContext) else { fatalError("нет контекста") }
//
//        self.init(entity: entity, insertInto: nil)
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.title = try values.decode(String.self, forKey: .title)
//        self.summary = try values.decode(String.self, forKey: .summary)
//
//    }
//
//
//}
