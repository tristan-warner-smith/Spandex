//
//  CharacterGrouping.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

enum CharacterGrouping: Hashable, CaseIterable {
    case all
    case goodies
    case baddies
    case human
    case nonHuman
}

extension CharacterGrouping: CustomStringConvertible {
    var description: String {
        switch self {
        case .all:
            return "All Characters"
        case .goodies:
            return "Goodies"
        case .baddies:
            return "Baddies"
        case.human:
            return "Human"
        case .nonHuman:
            return "Non-Human"
        }
    }
}
