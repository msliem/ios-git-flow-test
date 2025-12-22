//
//  TextInputView.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 04/12/2025.
//

import SwiftUI

struct DropDownView<Option: Hashable & CustomStringConvertible>: View {

    // MARK: - Public API
    let title: String
    let options: [Option]
    @Binding var selection: Option?

    // MARK: - State
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(selection?.description ?? "Select")
                        .foregroundColor(selection == nil ? .secondary : .primary)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 11)
                        .stroke(Color.gray.opacity(0.4))
                )
            }

            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selection = option
                            withAnimation(.easeInOut) {
                                isExpanded = false
                            }
                        } label: {
                            HStack {
                                Text(option.description)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 4)
                )
            }
        }
    }
}
