//
//  View+ShadowBackground.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import SwiftUI

extension View {

    func shadowBackgrounded(_ colorScheme: ColorScheme) -> some View {

        let backgrounded = self
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(.secondarySystemBackground)))

        return Group {
            if colorScheme == .dark {
                backgrounded
            } else {
                backgrounded
                .compositingGroup()
                .shadow(
                    color: Color.black.opacity(0.2),
                    radius: 16,
                    x: 4.0,
                    y: 4.0)
            }
        }
    }
}
