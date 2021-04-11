//
//  CharacterDetailView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import SwiftUI

enum DetailSection: Int, CustomStringConvertible, CaseIterable {
    case appearance
    case biography
    case power

    var description: String {
        switch self {
        case .biography:
            return "Biography"
        case .appearance:
            return "Appearance"
        case .power:
            return "Power"
        }
    }
}

struct CharacterDetailView<Loader>: View where Loader: ImageLoadable {

    let character: CharacterState
    @ObservedObject var imageLoader: Loader
    @State var loading: Bool = false
    @State var selectedSection = DetailSection.appearance
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 8) {

            dragHandle

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    image

                    Text(character.name)
                        .font(.system(.title2, design: .rounded))
                        .bold()

                    headers

                    sectionDetail

                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .font(.system(.headline, design: .rounded))
    }

    @ViewBuilder var headers: some View {

        Picker("", selection: $selectedSection) {

            ForEach(DetailSection.allCases, id: \.self) { section in
                Text(String(describing: section)).tag(section.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())

    }

    var dragHandle: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color(.gray))
            .frame(width: 35, height: 6)
            .padding(.top, 8)
    }

    @ViewBuilder var sectionDetail: some View {
        switch selectedSection {
        case .biography:
            details
        case .appearance:
            appearance
        case .power:
            powers
        }
    }

    var details: some View {
        VStack(alignment: .leading) {

            detailRow("Full name", character.biography.fullName)
            detailRow("Alter-egos", character.biography.alterEgos)
            detailRow("AKA", character.biography.aliases.joined(separator: ", "))
            detailRow("Born", character.biography.placeOfBirth)
            detailRow("Alignment", String(describing: character.biography.alignment))
        }
        .font(.system(.body, design: .rounded))
    }

    var appearance: some View {
        VStack(alignment: .leading) {
            detailRow("Race", character.appearance.race)
            detailRow("Gender", String(describing: character.appearance.gender))
            detailRow("Height", character.appearance.height)
            detailRow("Weight", character.appearance.weight)
            detailRow("Hair", character.appearance.hairColour)
            detailRow("Eyes", character.appearance.eyeColour)
        }
        .font(.system(.body, design: .rounded))
    }

    var powers: some View {
        VStack(alignment: .leading) {
            detailRow("Intelligence", String(describing: character.powers.intelligence))
            detailRow("Strength", String(describing: character.powers.strength))
            detailRow("Speed", String(describing: character.powers.speed))
            detailRow("Durability", String(describing: character.powers.durability))
            detailRow("Power", String(describing: character.powers.power))
            detailRow("Combat", String(describing: character.powers.combat))
        }
        .font(.system(.body, design: .rounded))
    }

    func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .layoutPriority(1)

            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(.separator).opacity(0.5))
                .frame(height: 4)

            Text(value)
                .font(.body).italic()
                .layoutPriority(1)
        }
    }

    @ViewBuilder var image: some View {
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
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
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
        let character = PreviewCharacterStateProvider().provide().randomElement()!

        return Group {

            ForEach(scenarios, id: \.id) { scenario in

                Color(.systemBackground)
                    .ignoresSafeArea()
                    .overlay(
                        CharacterDetailView(character: character, imageLoader: scenario.loader)
                    )
                    .previewDisplayName(scenario.name)

                Color(.systemBackground)
                    .ignoresSafeArea()
                    .overlay(
                        CharacterDetailView(character: character, imageLoader: scenario.loader)
                    )
                    .previewDisplayName("\(scenario.name) - Dark")
                    .colorScheme(.dark)
            }

        }
    }
}
