//
//  CharacterListItemView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct CharacterListItemView<Loader>: View where Loader: ImageLoadable {

    let character: CharacterState

    @ObservedObject var imageLoader: Loader
    @Environment(\.colorScheme) var colorScheme
    var select: (CharacterState) -> Void

    var body: some View {
        VStack(spacing: 12) {
            ImageView(imageLoader: imageLoader)

            Text(character.name)
                .font(.system(.headline, design: .rounded))
        }
        .onTapGesture {
            select(character)
        }
    }
}

struct CharacterListItemView_Previews: PreviewProvider {
    static var previews: some View {

        let imageLoadStates: [ImageLoadState] = [
            .notLoaded,
            .loading,
            .loaded(image: PreviewImageHelpers.urlImageMap.map { $0.value }.randomElement()!),
            .failed
        ]

        let scenarios: [(id: AnyHashable, loader: PreviewImageLoader, name: String)] = imageLoadStates.map { loadState in
            (UUID(), PreviewImageLoader(loadState: loadState), loadState.name)
        }
        let character = PreviewCharacterStateProvider().provide().first!

        return Group {

            ForEach(scenarios, id: \.id) { scenario in
                CharacterListItemView(
                    character: character,
                    imageLoader: scenario.loader,
                    select: { _ in }
                )
                .padding()
                .previewDisplayName(scenario.name)

                CharacterListItemView(
                    character: character,
                    imageLoader: scenario.loader,
                    select: { _ in }
                )
                .padding()
                .background(Color(.systemBackground))
                .previewDisplayName("\(scenario.name) - Dark")
                .colorScheme(.dark)
            }

        }.previewLayout(.sizeThatFits)
    }
}
