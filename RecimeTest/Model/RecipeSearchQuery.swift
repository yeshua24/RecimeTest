//
//  RecipeSearch.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import Foundation

struct RecipeSearchQuery {

    var keyword: String = ""
    var vegetarianOnly: Bool = false
    var servings: Int?
    var maxPrepTime: Int?

    var includedIngredients: Set<String> = []
    var excludedIngredients: Set<String> = []
}
