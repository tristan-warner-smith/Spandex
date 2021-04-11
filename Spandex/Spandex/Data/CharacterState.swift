//
//  CharacterState.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Foundation

struct CharacterState: Equatable {
    let id: Int
    let name: String
    let imageURL: URL
    let biography: Biography
    let appearance: Appearance
    let powers: Powers
}

struct Appearance: Equatable {
    let race: String
    let gender: Gender
    let hairColour: String
    let eyeColour: String
    let height: String
    let weight: String
}

struct Biography: Equatable {
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String
    let alignment: CharacterAlignment
}

struct Powers: Equatable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

enum CharacterAlignment: String, CustomStringConvertible {
    case good = "Good"
    case neutral = "Neutral"
    case bad = "Bad"
    case unknown = "Unknown"

    var description: String {
        rawValue
    }
}

enum Gender: String, CustomStringConvertible {
    case unknown = "-"
    case male = "Male"
    case female = "Female"

    var description: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
