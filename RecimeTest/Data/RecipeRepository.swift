//
//  RecipeRepository.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation

protocol RecipeServiceProtocol {
    func searchRecipes(query: RecipeSearchQuery) async throws -> [Recipe]
}
