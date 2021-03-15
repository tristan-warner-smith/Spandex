//
//  SpandexApp.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

@main
struct SpandexApp: App {
    var characters: [CharacterState] = PreviewCharacterStateProvider().provide()

    var body: some Scene {
        WindowGroup {
            ContentView(characters: characters, imageLoaderProvider: ImageLoaderProvider.shared)
        }
    }
}
