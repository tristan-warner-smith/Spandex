//
//  SpandexApp.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

@main
struct SpandexApp: App {
    @StateObject var search: SearchViewModel = SearchViewModel(characters: PreviewCharacterStateProvider().provide())
    @StateObject var favouriteStore = FavouriteStore()

    var body: some Scene {
        WindowGroup {
            ContentView(imageLoaderProvider: ImageLoaderProvider.shared)
            .environmentObject(search)
            .environmentObject(favouriteStore)
        }
    }
}
