//
//  AnyLayout.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 16/11/2025.
//

import SwiftUI

struct AnyLayoutView: View {
    
    @State private var collapsed = true

    private var layout: AnyLayout {
        collapsed ? AnyLayout(ZStackLayout()) : AnyLayout(VStackLayout(spacing: 8))
    }
    
    
    var body: some View {
        
        layout {
            
            actionButton("microphone", action: {})
            actionButton("camera", action: {})
            actionButton("calendar", action: {})
            
            
            toggleCollapseButton
            
        }
    }
    
    @ViewBuilder
    private var toggleCollapseButton: some View {
        let icon = collapsed ? "plus" : "multiply"
        
        Image(systemName: icon)
            .foregroundStyle(.white)
            .font(.system(size: 18, weight: .bold))
            .frame(width: 18, height: 18)
            .padding(15)
            .background(Circle().fill(.link))
            .contentShape(.circle)
            .contentTransition(.symbolEffect)
            .animation(.easeInOut(duration: 0.2), value: collapsed)
            .onTapGesture {
                collapsed.toggle()
            }
        
    }
    
    @ViewBuilder
    private func actionButton(_ icon: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
            collapsed = true
        } label: {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .bold))
                .frame(width: 18, height: 18)
                .padding(15)
                .background(Circle().fill(.link))
                .contentShape(.circle)
                .animation(.easeInOut(duration: 0.2), value: collapsed)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ScrollView {
        VStack {
            Text("AnyLayoutView")
        }
        .frame(maxWidth: .infinity)
    }
    .overlay(alignment: .bottomTrailing) {
        AnyLayoutView()
            .padding(.trailing, 24)
    }
}
