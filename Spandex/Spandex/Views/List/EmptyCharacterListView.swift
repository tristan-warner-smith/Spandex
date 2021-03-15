//
//  EmptyCharacterListView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct EmptyCharacterListView: View {

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("😅")
                    .font(.system(size: 100))
                Text("No characters here...")
            }
            Spacer()
        }
    }
}

struct EmptyCharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyCharacterListView()

            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                EmptyCharacterListView()
            }
            .colorScheme(.dark)
        }
    }
}
