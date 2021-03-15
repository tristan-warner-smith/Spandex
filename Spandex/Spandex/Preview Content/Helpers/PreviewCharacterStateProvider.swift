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
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/10060.jpg")!
            ),
            CharacterState(
                id: 2,
                name: "Abe Sapien",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/956.jpg")!
            ),
            CharacterState(
                id: 3,
                name: "Abin Sur",
                imageURL: URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/1460.jpg")!
            )
        ]
    }
}
