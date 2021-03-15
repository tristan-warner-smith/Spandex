//
//  CharacterListView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct CharacterListView<LoaderProvider>: View where LoaderProvider: ImageLoaderProviding {

    let characters: [CharacterState]

    var imageLoaderProvider: LoaderProvider

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 0) {
                ForEach(characters, id: \.id) { character in

                    CharacterListItemView(
                        character: character,
                        imageLoader: imageLoaderProvider.provide(url: character.imageURL)
                    )
                }
            }.padding(.horizontal)
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = PreviewCharacterStateProvider().provide()
        let imageLoaderProvider = PreviewImageLoaderProvider<PreviewImageLoader>()

        return Group {
                CharacterListView(characters: characters, imageLoaderProvider: imageLoaderProvider)
                    .background(Color(.systemBackground).ignoresSafeArea())

                CharacterListView(characters: characters, imageLoaderProvider: imageLoaderProvider)
                    .background(Color(.systemBackground).ignoresSafeArea())
                    .colorScheme(.dark)
        }
    }
}
