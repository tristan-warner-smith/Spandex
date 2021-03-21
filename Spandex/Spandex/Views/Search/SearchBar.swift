//
//  SearchBar.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 17/03/2021.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    let characters: [CharacterState]
    @Published var searchTerm: String = ""
    @Published var matchingCharacters: [CharacterState]
    @Published var showPlaceholder: Bool = false
    private var cancellable: AnyCancellable?

    init(characters: [CharacterState]) {
        self.characters = characters
        self.matchingCharacters = characters

        $searchTerm
            .map { term in
                term.isEmpty ? characters : characters.filter {
                    [
                        [$0.name],
                        $0.biography.aliases,
                        [$0.biography.alterEgos],
                        [$0.biography.fullName],
                        [$0.biography.placeOfBirth]
                    ]
                    .flatMap { $0 }
                    .contains(where: { searchField in
                        searchField.localizedCaseInsensitiveContains(term)
                    })
                }
            }
        .assign(to: &$matchingCharacters)

        $searchTerm
            .map { $0.trimmingCharacters(in: .whitespaces).isEmpty }
            .assign(to: &$showPlaceholder)
    }
}

struct SearchBar: View {

    @Binding var searchTerm: String
    @Binding var showPlaceholder: Bool
    let placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            ZStack(alignment: .leading) {
                if showPlaceholder {
                    Text(placeholder).foregroundColor(.init(white: 0.4)).allowsHitTesting(false)
                }

                TextField("", text: $searchTerm) { isEditing in
                    showPlaceholder = !isEditing
                } onCommit: {}
                .padding(.vertical)
            }
            .animation(.easeInOut)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(Color(.tertiarySystemFill))
        )
        .foregroundColor(.init(white: 0.4))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            SearchBar(searchTerm: .constant(""), showPlaceholder: .constant(true), placeholder: "Find a character by name or details")
            SearchBar(searchTerm: .constant(""), showPlaceholder: .constant(true), placeholder: "Find a character by name or details").colorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
