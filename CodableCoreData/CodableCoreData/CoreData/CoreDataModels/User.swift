//
//  User+CoreDataClass.swift
//  CodableCoreData
//
//  Created by Hudihka on 18/10/2021.
//
//

import Foundation
import CoreData

@objc(User)
public final class User: NSManagedObject {

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var userId: Int64
	
}

extension User: GGDecodable {
	static func create(_ json: JSON, context: NSManagedObjectContext?) -> User {
		let user = User(context: context ?? defaultContext!)
		if let term = json["userId"] as? Int64 {
			user.userId = term
		}
		if let term = json["id"] as? Int64 {
			user.id = term
		}
		if let term = json["title"] as? String {
			user.title = term
		}
		if let term = json["body"] as? String {
			user.body = term
		}
		
		return user
	}
}
