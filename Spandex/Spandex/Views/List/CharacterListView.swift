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
    var select: (CharacterState) -> Void

    @EnvironmentObject var favouriteStore: FavouriteStore

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
                spacing: 0
            ) {
                ForEach(characters, id: \.id) { character in

                    VStack(spacing: 12) {
                        CharacterListItemView(
                            character: character,
                            imageLoader: imageLoaderProvider.provide(url: character.imageURL)
                        )
                        .onTapGesture {
                            select(character)
                        }
                        .overlay(
                            favourite(
                                favourited: favouriteStore.isFavourited(id: character.id),
                                toggle: { favouriteStore.toggle(id: character.id) }
                            )
                            .offset(y: -6),
                            alignment: .topTrailing
                        )

                        Text(character.name)
                            .font(.system(.headline, design: .rounded))
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .animation(Animation.easeInOut.speed(2))
        }
    }

    func favourite(favourited: Bool, toggle: @escaping () -> Void) -> some View {
        ZStack {

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.01))
                .frame(width: 44, height: 44)
                .onTapGesture {
                    toggle()
                }

            Image(systemName: "bookmark.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)
                .foregroundColor(favourited ? Color(.systemRed) : Color.white)
                .shadow(radius: 2)
                .compositingGroup()
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = PreviewCharacterStateProvider().provide()
        let imageLoaderProvider = PreviewImageLoaderProvider<PreviewImageLoader>()
        let favouriteStore = FavouriteStore()
        characters.forEach { character in
            if Bool.random() {
                favouriteStore.toggle(id: character.id)
            }
        }

        return Group {
            CharacterListView(characters: characters, imageLoaderProvider: imageLoaderProvider, select: { _ in })
                .background(Color(.systemBackground).ignoresSafeArea())

            CharacterListView(characters: characters, imageLoaderProvider: imageLoaderProvider, select: { _ in })
                .background(Color(.systemBackground).ignoresSafeArea())
                .colorScheme(.dark)
        }
        .environmentObject(favouriteStore)
    }
}
