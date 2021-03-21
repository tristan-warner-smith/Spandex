//
//  EmptyCharacterListView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 15/03/2021.
//

import SwiftUI

struct EmptyCharacterListView: View {

    let searchTerm: String

    var titleMessage: String {
        searchTerm.isEmpty
            ? "No characters here..."
            : "No matches found for '\(searchTerm)'"
    }

    var helpMessage: String {
        searchTerm.isEmpty
            ? "We should find some for you!"
            : "Try a different search term?"
    }

    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                HStack {

                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .foregroundColor(Color(.systemFill))
                            .padding(.top)

                        Text(titleMessage)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color(.secondaryLabel))
                        Text(helpMessage)
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    .padding()

                    Spacer()
                }
                .padding(.vertical)
                Spacer()
            }

        }
        .background(
            RoundedRectangle(
                cornerRadius: 25.0,
                style: .continuous)
                .fill(Color(.quaternarySystemFill))
        )
        .padding()
    }
}

struct EmptyCharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyCharacterListView(searchTerm: "Captain")

            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                EmptyCharacterListView(searchTerm: "Captain")
            }
            .colorScheme(.dark)
        }
    }
}
