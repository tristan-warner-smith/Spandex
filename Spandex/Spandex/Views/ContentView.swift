//
//  ContentView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct ContentView<LoaderProvider>: View where LoaderProvider: ImageLoaderProviding {
    let characters: [CharacterState]
    let imageLoaderProvider: LoaderProvider

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            CharacterListView(characters: characters, imageLoaderProvider: imageLoaderProvider)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = PreviewCharacterStateProvider().provide()
        let imageLoaderProvider = PreviewImageLoaderProvider<PreviewImageLoader>()

        return Group {
            ContentView(characters: characters, imageLoaderProvider: imageLoaderProvider)
            ContentView(characters: characters, imageLoaderProvider: imageLoaderProvider)
                .colorScheme(.dark)
        }
    }
}
