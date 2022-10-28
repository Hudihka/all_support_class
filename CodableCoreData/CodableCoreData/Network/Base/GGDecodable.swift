//
//  GGDecodable.swift
//  CodableCoreData
//
//  Created by Hudihka on 18/10/2021.
//

import Foundation
import CoreData

protocol GGDecodable {
	static func create(_ json: JSON, context: NSManagedObjectContext?) -> Self
}
