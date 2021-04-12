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
    @EnvironmentObject var favourites: FavouriteStore
    @State var selectedCharacter: CharacterState?
    @State var showDetails: Bool = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack {

                header

                SearchBar(search: search, placeholder: "Find a character by name or details")
                    .padding([.top, .horizontal])

                GroupingListView().padding(.vertical, 8)

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
            detailsOverlay
                .ignoresSafeArea(.container, edges: .bottom)
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

    @ViewBuilder var detailsOverlay: some View {
        if let selected = selectedCharacter {
            CharacterDetailView(character: selected, imageLoader: imageLoaderProvider.provide(url: selected.imageURL))
                .padding([.bottom])

            Spacer()
        }
    }

    var dragHandle: some View {
        HStack {
            Spacer()

            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(.gray))
                .frame(width: 35, height: 6)
                .padding(.top, 8)

            Spacer()
        }
    }

    var header: some View {
        HStack(alignment: .top) {
            Text("Explore the world of ") + Text("Spandex").bold()

            Spacer()

            favouriteIndicator
        }
        .padding(.horizontal)
        .font(.system(.largeTitle, design: .rounded))
    }

    @ViewBuilder var favouriteIndicator: some View {

        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(Color(.systemBackground))
            .aspectRatio(contentMode: .fit)
            .frame(width: 44)
            .overlay(
                Image(systemName: "bookmark.fill")
                    .foregroundColor(Color(.systemGray4))
                    .shadow(color: Color.black.opacity(0.2), radius: 0, x: 2, y: 1)
            )
            .overlay(
                Group {
                    if favourites.favourites.isEmpty {
                        EmptyView()
                    } else {
                        Text("\(favourites.favourites.count)")
                            .foregroundColor(.white)
                            .font(Font.body.monospacedDigit())
                            .padding(6)
                            .background(Circle().fill(Color.red))
                            .offset(x: 9, y: -13)
                    }
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = PreviewCharacterStateProvider().provide()
        let imageLoaderProvider = PreviewImageLoaderProvider<PreviewImageLoader>()
        let search = SearchViewModel(characters: characters)
        let emptySearch = SearchViewModel(characters: [])

        let favourites = FavouriteStore()
        favourites.toggle(id: characters.first!.id)

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

            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(search)
                .environmentObject(FavouriteStore())
                .previewDisplayName("No favourites")

            ContentView(imageLoaderProvider: imageLoaderProvider)
                .environmentObject(search)
                .environmentObject(FavouriteStore())
                .colorScheme(.dark)
                .previewDisplayName("No favourites - Dark")
        }
        .environmentObject(favourites)
    }
}
