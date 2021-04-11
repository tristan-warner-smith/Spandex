//
//  SearchBar.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 17/03/2021.
//

import Combine
import SwiftUI

struct SearchBar: View {

    @ObservedObject var search: SearchViewModel
    let placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            ZStack(alignment: .leading) {
                if search.showPlaceholder {
                    Text(placeholder).foregroundColor(.init(white: 0.4)).allowsHitTesting(false)
                }

                TextField("", text: $search.searchTerm) { isEditing in
                    search.showPlaceholder = !isEditing
                } onCommit: {}
                .padding(.vertical)

                if search.showClear {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .font(Font.system(.body, design: .rounded).weight(.bold))
                            .frame(alignment: .trailing)
                            .overlay(Button(action: {
                                search.searchTerm = ""
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
    static var models = [SearchViewModel]()

    static var previews: some View {
        let characters = PreviewCharacterStateProvider().provide()

        let placeholder = "Find a character by name or details"
        let scenarios: [(id: UUID, searchTerm: String, showPlaceholder: Bool)] = [
            (UUID(), "", true),
            (UUID(), "Abomination", false)
        ]

        models = scenarios.map { scenario in
            let model = SearchViewModel(characters: characters)
            model.searchTerm = scenario.searchTerm
            model.showPlaceholder = scenario.showPlaceholder
            return model
        }

        return Group {
            ForEach(models) { search in
                SearchBar(search: search, placeholder: placeholder)
                SearchBar(search: search, placeholder: placeholder)
                    .colorScheme(.dark)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
