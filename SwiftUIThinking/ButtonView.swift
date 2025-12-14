//
//  Button.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 04/12/2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
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
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                )
        }
    }
}

struct ButtonView: View {
    var body: some View {
        PrimaryButton(title: "Tap it") {
            print("Tapped Button")
        }
    }
}

#Preview {
    ButtonView()
}
