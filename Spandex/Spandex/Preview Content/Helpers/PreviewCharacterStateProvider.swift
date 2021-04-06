//
//  PreviewCharacterStateProvider.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import Foundation

struct PreviewCharacterStateProvider {

    func provide() -> [CharacterState] {
        [
            CharacterState(
                id: 1,
                name: "A-Bomb",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/10060.jpg")!,
                biography: Biography(
                    fullName: "Richard Milhouse Jones",
                    alterEgos: "No alter egos found.",
                    aliases: ["Rick Jones"],
                    placeOfBirth: "Scarsdale, Arizona",
                    alignment: .good
                ),
                appearance: Appearance(race: "Human", gender: .male, hairColour: "No hair", eyeColour: "Yellow", height: "6'8 / 203 cm", weight: "980 lb / 441 kg"),
                powers: Powers(intelligence: 38, strength: 100, speed: 17, durability: 80, power: 24, combat: 64)
            ),
            CharacterState(
                id: 2,
                name: "Abe Sapien",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/956.jpg")!,
                biography: Biography(
                    fullName: "Abraham Sapien",
                    alterEgos: "No alter egos found.",
                    aliases: ["Langdon Everett Caul, Langdon Caul"],
                    placeOfBirth: "Unknown",
                    alignment: .good
                ),
                appearance: Appearance(race: "Icthyo Sapien", gender: .male, hairColour: "No Hair", eyeColour: "Blue", height: "6'3 / 191 cm", weight: "145 lb / 65 kg"),
                powers: Powers(intelligence: 88, strength: 28, speed: 35, durability: 65, power: 100, combat: 85)
            ),
            CharacterState(
                id: 3,
                name: "Abin Sur",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/1460.jpg")!,
                biography: Biography(
                    fullName: "Unknown",
                    alterEgos: "No alter egos found.",
                    aliases: ["Lagzia"],
                    placeOfBirth: "Ungara",
                    alignment: .good
                ),
                appearance: Appearance(race: "Ungaran", gender: .male, hairColour: "No hair", eyeColour: "Blue", height: "6'1 / 185 cm", weight: "200 lb / 90 kg"),
                powers: Powers(intelligence: 99, strength: 90, speed: 53, durability: 64, power: 99, combat: 65)
            ),
            CharacterState(
                id: 4,
                name: "Abomination",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/1.jpg")!,
                biography: Biography(
                    fullName: "Emil Blonsky",
                    alterEgos: "No alter egos found.",
                    aliases: ["Agent R-7", "Ravager of Worlds"],
                    placeOfBirth: "Zagreb, Yugoslavia",
                    alignment: .bad
                ),
                appearance: Appearance(race: "Human / Radiation", gender: .male, hairColour: "No hair", eyeColour: "Green", height: "6'8 / 203 cm", weight: "980 lb / 441 kg"),
                powers: Powers(intelligence: 63, strength: 80, speed: 53, durability: 90, power: 62, combat: 95)
            )
        ]
    }
}
