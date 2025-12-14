//
//  PhoneField.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//


import SwiftUI

struct PhoneField: View {
    @Binding var phoneNumber: String
    let title: String
    let prefix: String
    let showsDivider: Bool

    init(
        title: String = "Phone Number",
        prefix: String = "+996",
        showsDivider: Bool = true,
        phoneNumber: Binding<String>
    ) {
        self.title = title
        self.prefix = prefix
        self.showsDivider = showsDivider
        self._phoneNumber = phoneNumber
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(prefix)
                .font(.callout)
                .foregroundStyle(.secondary)

            if showsDivider {
                Divider()
                    .frame(height: 20)
            }

            TextField(title, text: $phoneNumber)
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
                .font(.callout)
                .padding(.vertical, 10)
        }
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
