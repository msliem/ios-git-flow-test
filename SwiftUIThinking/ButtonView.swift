//
//  Button.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 04/12/2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    init(title: String, color: Color, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.color = color
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color)
                )
        }
    }
}

struct ButtonView: View {
    var body: some View {
        PrimaryButton(title: "Tap it", color: .yellow) {
            print("Tapped Button")
        }
    }
}

#Preview {
    ButtonView()
}
