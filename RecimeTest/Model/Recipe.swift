//
//  Recipe.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import Foundation

struct Recipe: Identifiable, Hashable, Decodable {

    let id: Int
    let title: String
    let description: String
    let servings: Int
    let prepTime: Int
    let ingredients: [String]
    let instructions: [String]
    let imageUrl: String
    let isVegetarian: Bool
    
    static let mock : Recipe = .init(id: 0, title: "Spaghetti Carbonara", description: "A traditional Roman pasta dish made with eggs, Pecorino Romano, pancetta, and black pepper. The sauce becomes creamy by emulsifying eggs with hot pasta water — no cream required.", servings: 4, prepTime: 20, ingredients: [
        "400g spaghetti",
        "150g pancetta, diced",
        "3 large eggs",
        "1 egg yolk",
        "100g Pecorino Romano, grated",
        "1 tsp black pepper",
        "Salt for pasta water"
      ], instructions: [
        "Boil salted water and cook spaghetti until al dente.",
        "Cook pancetta until crispy.",
        "Whisk eggs, yolk, cheese, and pepper.",
        "Drain pasta and combine with pancetta.",
        "Remove from heat and quickly mix in egg mixture.",
        "Add pasta water until creamy."
      ], imageUrl: "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg", isVegetarian: false)
}
