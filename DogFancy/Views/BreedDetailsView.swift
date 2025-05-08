// Copyright © 2025 Josh Adams. All rights reserved.

import SwiftUI

struct BreedDetailsView: View {
  let breed: Breed
  let imageLoader: ImageLoader
  private let imageHeightWidth: CGFloat = 250.0
  @State private var image: UIImage?

  var body: some View {
    VStack {
      Text(breed.name)
        .font(.title)

      Group {
        if let image {
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
          image = await imageLoader.loadImage(url: url)
        }
      }

      Text(breed.lifespan)
        .font(.body)

      Text(breed.temperament ?? "UNKNOWN")
        .font(.body)
    }
  }
}
