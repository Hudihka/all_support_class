//
//  Pokemon.swift
//  bacground_task
//
//  Created by Константин Ирошников on 15.06.2022.
//

import Foundation

struct Pokemon: Codable {
  struct Species: Codable {
    let name: String
  }

  struct Sprites: Codable {
    let backDefault: URL?
    let backShiny: URL?
    let frontDefault: URL?
    let frontShiny: URL?

    enum CodingKeys: String, CodingKey {
      case backDefault = "back_default"
      case backShiny = "back_shiny"
      case frontDefault = "front_default"
      case frontShiny = "front_shiny"
    }
  }

  let species: Species
  let sprites: Sprites
}
