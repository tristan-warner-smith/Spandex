//
//  FavouriteStore.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import SwiftUI

final class FavouriteStore: ObservableObject {
    @Published private(set) var favourites = Set<Int>()

    func isFavourited(id: Int) -> Bool {
        favourites.contains(id)
    }

    func toggle(id: Int) {

        if isFavourited(id: id) {
            favourites.remove(id)
        } else {
            favourites.insert(id)
        }
    }
}
