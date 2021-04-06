//
//  CharacterListItemView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct CharacterListItemView<Loader>: View where Loader: ImageLoadable {

    let character: CharacterState
    @State var loading: Bool = false

    @ObservedObject var imageLoader: Loader
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 12) {
            switch imageLoader.image {
            case .loaded(let image):
                    image
                    .configured()
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .shadowBackgrounded(colorScheme)
            case .notLoaded:
                Image(systemName: "person.crop.square")
                    .configured()
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .shadowBackgrounded(colorScheme)

            case .loading:
                Image(systemName: "arrow.triangle.2.circlepath")
                    .configured()
                    .padding(80)
                    .rotationEffect(.degrees(loading ? 360 : 0))
                    .foregroundColor(Color(.secondarySystemFill))
                    .shadowBackgrounded(colorScheme)
                    .onAppear {
                        withAnimation(Animation
                                        .linear(duration: 1.2)
                                        .repeatForever(autoreverses: false)) {
                            loading = true }
                    }
                    .onDisappear { loading = false }

            case .failed:
                Image(systemName: "xmark")
                    .configured()
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .shadowBackgrounded(colorScheme)
            }

            Text(character.name)
                .font(.system(.headline, design: .rounded))
        }
        .padding(.bottom)
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
                CharacterListItemView(character: character, imageLoader: scenario.loader)
                    .padding()
                    .previewDisplayName(scenario.name)

                CharacterListItemView(character: character, imageLoader: scenario.loader)
                    .padding()
                    .background(Color(.systemBackground))
                    .previewDisplayName("\(scenario.name) - Dark")
                    .colorScheme(.dark)
            }

        }.previewLayout(.sizeThatFits)
    }
}
