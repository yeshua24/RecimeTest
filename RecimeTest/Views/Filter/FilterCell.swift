//
//  FilterCell.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import Foundation
import SwiftUI

struct IngredientCell: View {

    enum State {
        case normal
        case included
        case excluded
    }

    let ingredient: Ingredient
    let state: State
    var isMainList: Bool = false
    let onTap: () -> Void
    let onLongPress: () -> Void

    var body: some View {
        VStack(spacing: 8) {

            ZStack(alignment: .topTrailing) {

                Image(ingredient.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                
                if state != .normal && !isMainList {
                    badge
                }
            }

            Text(ingredient.name)
                .font(.caption)
        }
        .opacity(isMainList && state != .normal ? 0.3 : 1)
        .onTapGesture {
            onTap()
        }
        .onLongPressGesture {
            onLongPress()
        }
    }

    private var circleBackground: some View {
        Circle()
            .fill(Color(.systemGray6))
            .overlay(
                Circle().stroke(borderColor, lineWidth: 2)
            )
    }

    private var borderColor: Color {
        switch state {
        case .included: return .green
        case .excluded: return .red
        case .normal: return .clear
        }
    }

    private var badge: some View {
        Circle()
            .fill(.gray)
            .frame(width: 16, height: 16)
            .overlay(
                Image(systemName: "xmark")
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
            )
            .offset(x: 6, y: -6)
    }
}

// MARK: - Preview

#Preview("Normal") {
    IngredientCell(
        ingredient: Ingredient(name: "Tomato", imageName: "tomato"),
        state: .normal,
        isMainList: false,
        onTap: {},
        onLongPress: {}
    )
    .padding()
}

#Preview("Included") {
    IngredientCell(
        ingredient: Ingredient(name: "Tomato", imageName: "tomato"),
        state: .included,
        isMainList: false,
        onTap: {},
        onLongPress: {}
    )
    .padding()
}

#Preview("MainList Dimmed") {
    IngredientCell(
        ingredient: Ingredient(name: "Tomato", imageName: "tomato"),
        state: .included,
        isMainList: true,
        onTap: {},
        onLongPress: {}
    )
    .padding()
}
