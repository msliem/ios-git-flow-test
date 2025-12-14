//
//  BorderedText.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//

import SwiftUI

struct BorderedText: View {
    let text: String
    var style: BorderedTextStyle = .default

    var body: some View {
        Text(text)
            .modifier(BorderedTextModifier(style: style))
    }
}

private struct BorderedTextModifier: ViewModifier {
    let style: BorderedTextStyle

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.textColor)
            .lineLimit(style.lineLimit)
            .padding(.vertical, style.verticalPadding)
            .padding(.horizontal, style.horizontalPadding)
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
            )
    }
}

struct BorderedTextStyle {
    var font: Font
    var textColor: Color
    var borderColor: Color
    var borderWidth: CGFloat
    var cornerRadius: CGFloat
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var lineLimit: Int?

    static let `default` = BorderedTextStyle(
        font: .body,
        textColor: .primary,
        borderColor: .blue,
        borderWidth: 1.5,
        cornerRadius: 12,
        horizontalPadding: 12,
        verticalPadding: 8,
        lineLimit: nil
    )
}
