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
            : "No matches found"

    }

    var helpMessage: String {
        searchTerm.isEmpty
            ? "We should find some for you!"
            : "Try a different search term?"
    }

    var body: some View {
        VStack {

            HStack {

                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(.systemFill))

                        .padding()
                        .padding()
                        .background(
                            Circle()
                                .fill(Color(.systemFill)
                                )
                        )

                    Text(titleMessage)
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))

                    Text(helpMessage)
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))
                }
                .padding()

                Spacer()
            }
            .padding(.vertical)
        }
    }
}

struct EmptyCharacterListView_Previews: PreviewProvider {
    static var previews: some View {

        let scenarios: [String] = [
            "Captain",
            ""
        ]

        return Group {

            ForEach(ColorScheme.allCases, id: \.hashValue) { colorScheme in
                ForEach(scenarios, id: \.self) { scenario in
                    EmptyCharacterListView(searchTerm: scenario)
                        .background(Color(.systemBackground))
                        .colorScheme(colorScheme)
                        .previewDisplayName("\(colorScheme) - \(scenario.isEmpty ? "No search term" : scenario)")
                        .previewLayout(.sizeThatFits)
                }
            }
        }
    }
}
