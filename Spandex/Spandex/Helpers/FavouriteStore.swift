//
//  FavouriteStore.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import SwiftUI

final class FavouriteStore: ObservableObject {
    private var favourites = [Int: Bool]()

    func isFavourited(id: Int) -> Bool {
        favourites[id] ?? false
    }

    func toggle(id: Int) {

        DispatchQueue.main.async { [weak self] in
            self?.objectWillChange.send()
        }

        if let favourite = favourites[id] {
            favourites[id] = !favourite
        } else {
            favourites[id] = true
        }
    }
}
