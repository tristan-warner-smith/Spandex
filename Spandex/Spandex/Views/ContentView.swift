//
//  ContentView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State var characters: [CharacterState] = []

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            SuperHeroListView(characters: characters)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .colorScheme(.dark)
        }
    }
}
