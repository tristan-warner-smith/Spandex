//
//  ImageLoader.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Combine
import SwiftUI

final class ImageLoader: ImageLoadable {
    @Published var image: ImageLoadState = .notLoaded

    init(url: URL?) {
        guard let url = url else {
            image = .notLoaded
            return
        }

        image = .loading

        Self.download(url: url)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }

    static func download(url: URL) -> AnyPublisher<ImageLoadState, Never> {

        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .flatMap { (data, _) -> AnyPublisher<ImageLoadState, Never> in
                if let image = UIImage(data: data) {
                    return Just(.loaded(image: Image(uiImage: image))).eraseToAnyPublisher()
                } else {
                    return Just(.failed).eraseToAnyPublisher()
                }
            }
            .catch { _ in
                Just(.failed)
            }
            .eraseToAnyPublisher()
    }
}
