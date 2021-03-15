//
//  ImageLoaderProvider.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Foundation

final class ImageLoaderProvider: ImageLoaderProviding {

    static var shared: ImageLoaderProvider = ImageLoaderProvider()

    private var loaderCache: [URL: ImageLoader] = [:]

    private init() {}

    func provide(url: URL) -> ImageLoader {

        if let loader = loaderCache[url] {
            return loader
        }

        let loader = ImageLoader(url: url)
        loaderCache[url] = loader
        return loader
    }
}
