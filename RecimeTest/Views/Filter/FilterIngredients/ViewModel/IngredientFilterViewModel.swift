//
//  IngredientFilterViewModel.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI
internal import Combine

final class IngredientFilterViewModel: ObservableObject {

    @Published var included: Set<String>
    @Published var excluded: Set<String>
    @Published var searchText: String = ""

    private let allIngredients: [Ingredient]

    init(
        ingredients: [Ingredient],
        included: Set<String>,
        excluded: Set<String>
    ) {
        self.allIngredients = ingredients
        self.included = included
        self.excluded = excluded
    }

    // MARK: Filtering

    var filteredIngredients: [Ingredient] {
        guard !searchText.isEmpty else { return allIngredients }

        return allIngredients.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    func state(for ingredient: Ingredient) -> IngredientCell.State {
        if included.contains(ingredient.name) { return .included }
        if excluded.contains(ingredient.name) { return .excluded }
        return .normal
    }

    // MARK: Actions

    func tap(_ ingredient: Ingredient) {
        if included.contains(ingredient.name) {
            included.remove(ingredient.name)
        } else {
            excluded.remove(ingredient.name)
            included.insert(ingredient.name)
        }
    }

    func longPress(_ ingredient: Ingredient) {
        if excluded.contains(ingredient.name) {
            excluded.remove(ingredient.name)
        } else {
            included.remove(ingredient.name)
            excluded.insert(ingredient.name)
        }
    }
}
