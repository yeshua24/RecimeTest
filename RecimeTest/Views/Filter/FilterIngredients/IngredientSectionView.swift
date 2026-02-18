//
//  IngredientSectionView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI

struct IngredientSectionView: View {

    let title: String
    let items: [String]
    let state: IngredientCell.State
    let remove: (String) -> Void

    private let grid = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)

            LazyVGrid(columns: grid, spacing: 16) {
                ForEach(items, id: \.self) { name in
                    IngredientCell(
                        ingredient: Ingredient(name: name, imageName: name.lowercased()),
                        state: state
                    ) {
                        remove(name)
                    } onLongPress: {
                        remove(name)
                    }
                }
            }
        }
    }
}
