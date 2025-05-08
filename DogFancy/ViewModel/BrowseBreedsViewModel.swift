// Copyright © 2025 Josh Adams. All rights reserved.

import Observation
import SwiftUI

@Observable class BrowseBreedsViewModel {
  enum LoadingState: Equatable {
    case loading
    case loaded([Breed])
    case error
  }

  var loadingState = LoadingState.loading

  func loadBreeds() async {
    let breeds = await BreedLoader.loadBreeds()
    if let breeds {
      loadingState = .loaded(breeds)
    } else {
      loadingState = .error
    }
  }
}
