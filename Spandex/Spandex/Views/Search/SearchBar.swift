//
//  SearchBar.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 17/03/2021.
//

import Combine
import SwiftUI

struct SearchBar: View {

    @Binding var searchTerm: String
    @Binding var showPlaceholder: Bool
    let placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            ZStack(alignment: .leading) {
                if showPlaceholder {
                    Text(placeholder).foregroundColor(.init(white: 0.4)).allowsHitTesting(false)
                }

                TextField("", text: $searchTerm) { isEditing in
                    showPlaceholder = !isEditing
                } onCommit: {}
                .padding(.vertical)

                if !showPlaceholder && searchTerm.count > 1 {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .font(Font.system(.body, design: .rounded).weight(.bold))
                            .frame(alignment: .trailing)
                            .overlay(Button(action: {
                                searchTerm = ""
                            }) {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 44, height: 44)
                            })
                    }
                }
            }
            .animation(.easeInOut)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(Color(.tertiarySystemFill))
        )
        .foregroundColor(.init(white: 0.4))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {

        let placeholder = "Find a character by name or details"
        let scenarios: [(id: UUID, searchTerm: String, showPlaceholder: Bool)] = [
            (UUID(), "", true),
            (UUID(), "Abomination", false)
        ]

        return Group {

            ForEach(scenarios, id: \.id) { scenario in
                SearchBar(
                    searchTerm: .constant(scenario.searchTerm),
                    showPlaceholder: .constant(scenario.showPlaceholder),
                    placeholder: placeholder
                )
                .padding()
                .background(Color(.systemBackground))

                SearchBar(
                    searchTerm: .constant(scenario.searchTerm),
                    showPlaceholder: .constant(scenario.showPlaceholder),
                    placeholder: placeholder
                )
                .padding()
                .background(Color(.systemBackground))
                .colorScheme(.dark)
                .previewDisplayName("Dark")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
