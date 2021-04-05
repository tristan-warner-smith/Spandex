//
//  ContentView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Combine
import SwiftUI

struct ContentView<LoaderProvider>: View where LoaderProvider: ImageLoaderProviding {
    let characters: [CharacterState]
    let imageLoaderProvider: LoaderProvider
    @StateObject var search: SearchViewModel

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack {

                header

                SearchBar(
                    searchTerm: $search.searchTerm,
                    showPlaceholder: $search.showPlaceholder,
                    placeholder: "Find a character by name or details")
                    .padding([.top, .horizontal])

                GroupingListView(
                    selection: $search.grouping,
                    changeGroupingTo: { group in
                        withAnimation {
                            search.group(by: group)
                        }
                    }
                )
                .padding(.vertical, 8)

                if search.matchingCharacters.isEmpty {
                    EmptyCharacterListView(searchTerm: search.searchTerm)
                } else {
                    CharacterListView(characters: search.matchingCharacters, imageLoaderProvider: imageLoaderProvider)
                    .padding(.horizontal, 16)
                }
                Spacer()
            }.transition(.slide)
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
            ContentView(characters: characters, imageLoaderProvider: imageLoaderProvider, search: search)
                .previewDisplayName("Populated")
            ContentView(characters: characters, imageLoaderProvider: imageLoaderProvider, search: search)
                .colorScheme(.dark)
                .previewDisplayName("Populated - Dark")

            ContentView(characters: [], imageLoaderProvider: imageLoaderProvider, search: emptySearch)
                .previewDisplayName("Empty")
            ContentView(characters: [], imageLoaderProvider: imageLoaderProvider, search: emptySearch)
                .colorScheme(.dark)
                .previewDisplayName("Empty - Dark")
        }
    }
}
