//
//  SuperHeroListView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct CharacterState {
    let id: Int
    let name: String
}

struct SuperHeroListView: View {

    var characters: [CharacterState]

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(characters, id: \.id) { character in

                    VStack {

                        Text(character.name)
                            .foregroundColor(Color(.label))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .stroke(Color(.systemFill)))
                }
            }
        }
    }
}

struct SuperHeroListView_Previews: PreviewProvider {
    static var previews: some View {

        let characters = [
            CharacterState(
                id: 1,
                name: "A-Bomb"
            ),
            CharacterState(
                id: 2,
                name: "Abe Sapien"
            )
        ]

        return Group {
            SuperHeroListView(characters: characters)
                .background(Color(.systemBackground).ignoresSafeArea())

            SuperHeroListView(characters: characters)
                .background(Color(.systemBackground).ignoresSafeArea())
                .colorScheme(.dark)
        }
    }
}
