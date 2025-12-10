//
//  Button.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 04/12/2025.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
            print("Tapped Button")
        } label: {
            Text("Tap it")
                .font(.headline)
                .fontWeight(.bold)
                .background(
                    Rectangle().fill(.blue)
                )
        }
    }
}

#Preview {
    ButtonView()
}
