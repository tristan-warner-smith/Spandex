//
//  SpandexApp.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

@main
struct SpandexApp: App {

    @StateObject var search = SearchViewModel(characters: PreviewCharacterStateProvider().provide())

    var body: some Scene {
        WindowGroup {
            ContentView(imageLoaderProvider: ImageLoaderProvider.shared)
                .environmentObject(search)
        }
    }
}
