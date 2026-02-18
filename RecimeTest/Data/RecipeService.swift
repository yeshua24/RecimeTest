//
//  RecipeService.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation

final class RecipeService: RecipeServiceProtocol {
    
    /*
    *** this is the correct way if we're just getting it locally
    so no need to load the recipes when searching. Just using single source and
    just load the recipe once ***
    
    private let recipes: [Recipe] = []
     
    func searchRecipes(query: RecipeSearchQuery) async throws -> [Recipe] {
        filter(recipes, with: query)
    }
    
     private static func loadRecipes() -> [Recipe] {
         guard let url = Bundle.main.url(
             forResource: "recipes",
             withExtension: "json"
         ) else {
             return []
         }
         
         do {
             let data = try Data(contentsOf: url)
             let response = try JSONDecoder().decode(RecipesResponse.self, from: data)
             return response.data
         } catch {
             print("Failed to load recipes: \(error)")
             return []
         }
     }
     
    */
    
    
    func searchRecipes(query: RecipeSearchQuery) async throws -> [Recipe] {
        
        // We're doing this for a realistic MOCK API
        guard let url = Bundle.main.url(
            forResource: "recipes",
            withExtension: "json"
        ) else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(RecipesResponse.self, from: data)
        
        return filter(response.data, with: query)
    }
    
    
    private func filter(_ recipes: [Recipe],
                        with query: RecipeSearchQuery) -> [Recipe] {
        
         recipes.filter { recipe in
            
            // Vegetarian
            if query.vegetarianOnly && !recipe.isVegetarian {
                return false
            }
            
            // Servings
            if let servings = query.servings,
               recipe.servings != servings {
                return false
            }
            
            // Title / Description search / Instructions
            if !query.keyword.isEmpty {
                let matchesTitle =
                recipe.title.localizedCaseInsensitiveContains(query.keyword)
                
                let matchesDescription =
                recipe.description.localizedCaseInsensitiveContains(query.keyword)
                
                let instructionContains = recipe.instructions.description.localizedCaseInsensitiveContains(query.keyword)
                
                if !matchesTitle && !matchesDescription && !instructionContains {
                    return false
                }
            }
            
            // Include ingredients
            if !query.includedIngredients.isEmpty {
                let containsAll = query.includedIngredients.allSatisfy { ingredient in
                    recipe.ingredients.contains {
                        $0.localizedCaseInsensitiveContains(ingredient)
                    }
                }
                
                if !containsAll {
                    return false
                }
            }
            
            // Exclude ingredients
            if !query.excludedIngredients.isEmpty {
                let containsExcluded = query.excludedIngredients.contains { ingredient in
                    recipe.ingredients.contains {
                        $0.localizedCaseInsensitiveContains(ingredient)
                    }
                }
                
                if containsExcluded {
                    return false
                }
            }
            
            // Prep time filter
            if let maxPrepTime = query.maxPrepTime,
               recipe.prepTime > maxPrepTime {
                return false
            }
            
            return true
        }
        
    }
}
