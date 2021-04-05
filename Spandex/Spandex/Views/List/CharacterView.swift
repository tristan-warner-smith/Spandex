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
            switch imageLoader.image {
            case .loaded(let image):
                resizableImage(image)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .shadowBackgrounded(colorScheme, opacity: 0.8)

            case .notLoaded:
                resizableImage(Image(systemName: "person.crop.square"))
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .shadowBackgrounded(colorScheme)

            case .loading:
                resizableImage(Image(systemName: "arrow.triangle.2.circlepath"))
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
                resizableImage(Image(systemName: "xmark"))
                    .padding(60)
                    .foregroundColor(Color(.secondarySystemFill))
                    .shadowBackgrounded(colorScheme)
            }
    }

    func resizableImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

extension View {

    func shadowBackgrounded(_ colorScheme: ColorScheme, opacity: Double = 0.2) -> some View {

        let backgrounded = self
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(.secondarySystemBackground)))

        return Group {
            if colorScheme == .dark {
                backgrounded
                    .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(Color(.secondarySystemFill), lineWidth: 2))
            } else {
                backgrounded
                .compositingGroup()
                .shadow(
                    color: Color.black.opacity(opacity),
                    radius: 4,
                    x: 2.0,
                    y: 2)
            }
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
