//
//  ReusablePasswordField.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 10/12/2025.
//

import SwiftUI

struct ReusablePasswordField: View {
    
    @Binding var text: String
    var title: String = "Pass"
    var placeholder: String = "Enter Password ..."

    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text(title)
                .font(.headline)
            
            HStack {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
    }
}
