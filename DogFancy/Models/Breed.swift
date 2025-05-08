// Copyright © 2025 Josh Adams. All rights reserved.

import Foundation

struct Breed: Decodable, Equatable, Identifiable {
  let id: Int
  let name: String
  let breedGroup: BreedGroup?
  let temperament: String?
  let dogImage: DogImage
  let lifespan: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case breedGroup = "breed_group"
    case temperament
    case dogImage = "image"
    case lifespan = "life_span"
  }
}
