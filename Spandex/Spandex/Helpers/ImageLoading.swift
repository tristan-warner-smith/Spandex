//
//  ImageLoading.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

protocol ImageLoadable: ObservableObject {
    var image: ImageLoadState { get }
}

protocol ImageLoaderProviding {
    associatedtype Loader where Loader: ImageLoadable

    func provide(url: URL) -> Loader
}

enum ImageLoadState: Equatable {
    case notLoaded
    case loading
    case loaded(image: Image)
    case failed

    var name: String {
        switch self {
        case .notLoaded: return "Not loaded"
        case .loading: return "Loading"
        case .loaded: return "Loaded"
        case .failed: return "Failed"
        }
    }
}
