//
//  SearchViewModel.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    let characters: [CharacterState]
    @Published var searchTerm: String = ""
    @Published var matchingCharacters: [CharacterState]
    @Published var showPlaceholder: Bool = false
    @Published var grouping: CharacterGrouping = .all
    private var cancellable: AnyCancellable?

    init(characters: [CharacterState]) {
        self.characters = characters
        self.matchingCharacters = characters

        $grouping
            .combineLatest($searchTerm)
            .map { group, term in
                let groupFilteredCharacters = Self.filtered(characters, by: group)
                return term.isEmpty ? groupFilteredCharacters : groupFilteredCharacters.filter {
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

    func group(by grouping: CharacterGrouping) {
        guard self.grouping != grouping else { return }
        self.grouping = grouping
    }

    private static func filtered(_ characters: [CharacterState], by group: CharacterGrouping) -> [CharacterState] {
        switch group {
        case .all:
            return characters
        case .goodies:
            return characters.filter { $0.biography.alignment == .good }
        case .baddies:
            return characters.filter { $0.biography.alignment == .bad }
        case .human:
            return characters.filter { $0.appearance.race.contains("Human") }
        case .nonHuman:
            return characters.filter { !$0.appearance.race.contains("Human") }
        }
    }
}
