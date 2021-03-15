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

    var body: some View {
        VStack {
            switch imageLoader.image {
            case .loaded(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            case .notLoaded:
                Image(systemName: "person.crop.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(.quaternarySystemFill)))

            case .loading:
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(80)
                    .rotationEffect(.degrees(loading ? 360 : 0))
                    .foregroundColor(Color(.secondarySystemFill))
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(.quaternarySystemFill)))
                    .onAppear {
                        withAnimation(Animation
                                        .linear(duration: 1.2)
                                        .repeatForever(autoreverses: false)) {
                            loading = true }
                    }
                    .onDisappear { loading = false }

            case .failed:
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(.quaternarySystemFill)))
            }

            Text(character.name)
                .padding(.bottom)
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
