//
//  OutlineButton.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//


import SwiftUI

struct OutlineButton: View {
    let title: String
    let action: () -> Void
    var cornerRadius: CGFloat = 16
    var borderColor: Color = .blue
    var textColor: Color = .blue
    var horizontalPadding: CGFloat = 16
    var verticalPadding: CGFloat = 12

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(textColor)
                .font(.headline)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1.5)
                )
        }
    }
}
