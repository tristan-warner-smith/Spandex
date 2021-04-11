//
//  Image+Resizing.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 05/04/2021.
//

import SwiftUI

extension Image {

    func configured() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
