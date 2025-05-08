// Copyright © 2025 Josh Adams. All rights reserved.

import Foundation

enum BreedLoader {
  static func loadBreeds() async -> [Breed]? {
    let urlString = "https://api.thedogapi.com/v1/breeds?api_key=API_KEY"
    guard let url = URL(string: urlString) else {
      return nil
    }

    do {
      let (jsonData, _) = try await URLSession.shared.data(from: url)
      let breeds = try JSONDecoder().decode([Breed].self, from: jsonData)
      return breeds
    } catch {
      return nil
    }
  }
}
