//
//  GAError.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 17.10.2021.
//

import Foundation

struct GGError: Decodable {
    let type: ErrorType
    let message: String?

    enum ErrorType: String, Decodable {
      case EFridgeAlreadyClosed
	  case decodeError
      case other

      init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ErrorType(rawValue: label) ?? .other
      }
    }

	static var codableError: GGError {
		return GGError(
			type: .decodeError,
			message: "Не получлос декодировать"
		)
	}
}
}
