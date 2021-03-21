//
//  CharacterState.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Foundation

struct CharacterState {
    let id: Int
    let name: String
    let imageURL: URL
    let biography: Biography
}

struct Biography {
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String
    let alignment: CharacterAlignment
}

enum CharacterAlignment: String {
    case good = "Good"
    case neutral = "Neutral"
    case bad = "Evil"
    case unknown = "Unknown"
}
