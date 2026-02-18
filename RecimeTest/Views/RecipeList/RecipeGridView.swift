//
//  RecipeGridView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI

struct RecipeGridView: View {

    let recipes: [Recipe]

    private let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeCardView(recipe: recipe)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
}
