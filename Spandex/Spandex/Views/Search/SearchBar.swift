//
//  SearchBar.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 17/03/2021.
//

import Combine
import SwiftUI

struct SearchBar: View {

    @EnvironmentObject var search: SearchViewModel
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
        let characters = PreviewCharacterStateProvider().provide()
        let search = SearchViewModel(characters: characters)

        return Group {
            SearchBar(placeholder: "Find a character by name or details")
            SearchBar(placeholder: "Find a character by name or details")
                .colorScheme(.dark)
        }
        .environmentObject(search)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
