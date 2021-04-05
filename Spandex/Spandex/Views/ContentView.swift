//
//  ContentView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Combine
import SwiftUI

struct ContentView<LoaderProvider>: View where LoaderProvider: ImageLoaderProviding {

    @EnvironmentObject var search: SearchViewModel
    let imageLoaderProvider: LoaderProvider

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack {

                header

                SearchBar(placeholder: "Find a character by name or details")
                    .padding([.top, .horizontal])

                GroupingListView()
                .padding(.vertical, 8)

                if search.matchingCharacters.isEmpty {
                    EmptyCharacterListView(searchTerm: search.searchTerm)
                } else {
                    CharacterListView(
                        characters: search.matchingCharacters,
                        imageLoaderProvider: imageLoaderProvider
                    )
                    .padding([.bottom, .horizontal])
                }

                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            .transition(.slide)
        }
    }

    var header: some View {
        HStack {
            Text("Explore the world of ") + Text("Spandex").bold()

            Spacer()
        }
        .padding(.horizontal)
        .font(.system(.largeTitle, design: .rounded))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = PreviewCharacterStateProvider().provide()
        let imageLoaderProvider = PreviewImageLoaderProvider<PreviewImageLoader>()
        let search = SearchViewModel(characters: characters)
        let emptySearch = SearchViewModel(characters: [])

        return Group {
            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(search)
                .previewDisplayName("Populated")

            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(search)
                .colorScheme(.dark)
                .previewDisplayName("Populated - Dark")

            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(emptySearch)
                .previewDisplayName("Empty")

            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(emptySearch)
                .colorScheme(.dark)
                .previewDisplayName("Empty - Dark")
        }

    }
}
