//
//  PhoneField.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//


import SwiftUI

struct PhoneField: View {
    @Binding var phoneNumber: String
    var placeholder: String = "Phone Number"
    var prefix: String = "+20" // Change as needed

    var body: some View {
        HStack {
            Text(prefix)
                .padding(.leading, 8)
                .foregroundStyle(.secondary)

            TextField(placeholder, text: $phoneNumber)
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
                .padding(.vertical, 10)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
