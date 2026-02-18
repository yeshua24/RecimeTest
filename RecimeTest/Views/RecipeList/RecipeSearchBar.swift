//
//  RecipeSearchBar.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI

struct RecipeSearchBar: View {

    @Binding var text: String
    @Binding var isSearching: Bool
    @FocusState.Binding var isFocused: Bool

    let onSearch: () -> Void

    var body: some View {
        HStack(spacing: 8) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search here...", text: $text)
                .focused($isFocused)
                .onChange(of: text) { onSearch() }

            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    text = ""
                    isSearching = false
                    onSearch()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .tint(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.orange, lineWidth: 2)
                )
                .shadow(color: Color.orange.opacity(0.25), radius: 6, y: 2)
        )
    }
}
