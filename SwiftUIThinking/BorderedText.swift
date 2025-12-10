//
//  BorderedText.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//

import SwiftUI

struct BorderedText: View {
    let text: String
    
    // Customizable properties
    var font: Font = .body
    var textColor: Color = .primary
    var borderColor: Color = .blue
    var cornerRadius: CGFloat = 12
    var horizontalPadding: CGFloat = 12
    var verticalPadding: CGFloat = 8
    var lineLimit: Int? = nil

    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1.5)
            )
    }
}
