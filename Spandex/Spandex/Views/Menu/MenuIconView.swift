//
//  MenuIconView.swift
//  Spandex
//
//  Created by Tristan Warner-Smith on 21/03/2021.
//

import SwiftUI

struct MenuIconView: View {
    var body: some View {
        ZStack {
            menuDot
            menuDot.offset(x: 14)
            menuDot.offset(y: 14)
            menuDot.offset(x: 14, y: 14)
        }
        .foregroundColor(Color.black)
    }

    var menuDot: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(
                width: 8,
                height: 8
            )
    }
}

struct MenuIconView_Previews: PreviewProvider {
    static var previews: some View {
        MenuIconView()
    }
}
