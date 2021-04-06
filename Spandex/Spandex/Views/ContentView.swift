//
//  ContentView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Combine
import SwiftUI

struct ContentView<LoaderProvider>: View where LoaderProvider: ImageLoaderProviding {

    let imageLoaderProvider: LoaderProvider
    @EnvironmentObject var search: SearchViewModel
    @State var selectedCharacter: CharacterState?
    @State var showDetails: Bool = false

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

                    Spacer()
                } else {
                    CharacterListView(
                        characters: search.matchingCharacters,
                        imageLoaderProvider: imageLoaderProvider,
                        select: { character in
                            withAnimation {
                                selectedCharacter = character
                            }
                        }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .transition(.slide)
        }
        .sheet(isPresented: $showDetails) {
            overlay
        }
        .onChange(of: selectedCharacter) { character in
            withAnimation {
                showDetails = character != nil
            }
        }
        .onChange(of: showDetails) { show in
            if !show && selectedCharacter != nil {
                selectedCharacter = nil
            }
        }
    }

    @ViewBuilder var overlay: some View {
        if let selected = selectedCharacter {
            CharacterDetailView(character: selected, imageLoader: imageLoaderProvider.provide(url: selected.imageURL))
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
