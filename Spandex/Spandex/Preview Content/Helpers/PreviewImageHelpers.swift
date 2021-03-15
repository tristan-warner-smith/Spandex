//
//  PreviewImageHelpers.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Combine
import SwiftUI

final class PreviewImageLoader: ImageLoadable {
    @Published var image: ImageLoadState

    init(loadState: ImageLoadState = .notLoaded) {
        self.image = loadState
    }
}

final class PreviewImageLoaderProvider<Loader>: ImageLoaderProviding where Loader: ImageLoadable {

    let previewImageMap: [URL: Image]

    init(previewImageMap: [URL: Image] = PreviewImageHelpers.urlImageMap) {
        self.previewImageMap = previewImageMap
    }

    func provide(url: URL) -> some ImageLoadable & AnyObject {

        guard
            let previewImage = previewImageMap.first(where: { (key, _) in
                key == url
            })?.value
        else {
            assertionFailure("No matching image in preview asset catalog for \(url)")
            return PreviewImageLoader(loadState: .failed)
        }
        return PreviewImageLoader(loadState: .loaded(image: previewImage))
    }
}

struct PreviewImageHelpers {

    static let urlImageMap: [URL: Image] = [
        URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/10060.jpg")!: Image(uiImage: UIImage(named: "A-Bomb")!),
        URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/956.jpg")!: Image(uiImage: UIImage(named: "Abe-Sapien")!),
        URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/1460.jpg")!: Image(uiImage: UIImage(named: "Abin-Sur")!)
    ]

    static let image = Self.urlImageMap.first!.value

    static let imageLoaderScenarios: [PreviewImageLoader] = [
        PreviewImageLoader(loadState: .notLoaded),
        PreviewImageLoader(loadState: .loading),
        PreviewImageLoader(loadState: .loaded(image: Self.image)),
        PreviewImageLoader(loadState: .failed)
    ]
}
