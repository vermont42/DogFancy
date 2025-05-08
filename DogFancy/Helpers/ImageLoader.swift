// Copyright © 2025 Josh Adams. All rights reserved.

import UIKit

actor ImageLoader {
  enum LoaderState {
    case loaded(UIImage)
    case loading(Task<UIImage, Error>)
  }

  private var loaderStates: [URL: LoaderState] = [:]
  private let errorImage = UIImage(systemName: "cloud.drizzle") ?? UIImage()

  func loadImage(url: URL) async -> UIImage {
    var currentTask: Task<UIImage, Error>?

    if let loaderState = loaderStates[url] {
      switch loaderState {
      case .loaded(let image):
        return image
      case .loading(let runningTask):
        currentTask = runningTask
      }
    }

    if currentTask == nil {
      let newTask = Task<UIImage, Error> {
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          let image = UIImage(data: data) ?? errorImage
          return image
        } catch {
          return errorImage
        }
      }
      currentTask = newTask
    }

    guard let currentTask else {
      return errorImage
    }

    do {
      let image = try await currentTask.value
      return image
    } catch {
      return errorImage
    }
  }
}
