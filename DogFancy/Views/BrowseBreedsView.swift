// Copyright © 2025 Josh Adams. All rights reserved.

import SwiftUI

struct BrowseBreedsView: View {
  @State private var viewModel = BrowseBreedsViewModel()
  @State private var images: [URL: UIImage] = [:]
  private let imageHeightWidth: CGFloat = 150.0
  private let imageLoader = ImageLoader()

  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.loadingState {
        case .loading:
          ProgressView()
        case .error:
          Image(systemName: "cloud.drizzle")
        case .loaded(let breeds):
          list(of: breeds)
        }
      }
      .navigationTitle("Breeds")
    }
    .task {
      await viewModel.loadBreeds()
    }
  }

  func list(of breeds: [Breed]) -> some View {
    List(breeds) { breed in
      NavigationLink {
        BreedDetailsView(breed: breed, imageLoader: imageLoader)
      } label: {
        HStack {
          VStack(alignment: .leading) {
            Text(breed.name)
              .font(.body)
            Text(breed.breedGroup?.rawValue ?? "UNKNOWN")
              .font(.caption)
          }

          Spacer()

          Group {
            if
              let url = URL(string: breed.dogImage.url),
              let image = images[url]
            {
              Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            } else {
              ProgressView()
            }
          }
          .frame(width: imageHeightWidth, height: imageHeightWidth)
          .task {
            if let url = URL(string: breed.dogImage.url) {
              images[url] = await imageLoader.loadImage(url: url)
            }
          }
        }
      }
    }
  }
}
