//
//  RecipeListViewModel.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class RecipeListViewModel: ObservableObject {
    
    @Namespace private var searchNamespace
    private let searchDebouncer = Debouncer(delay: 0.35)
    @Published var recipes: [Recipe] = []
    @Published var search = RecipeSearchQuery()
    
    private let service: RecipeService
    
    @Published var isSearching: Bool = false
    
    @Published var showServingsSheet: Bool = false
    @Published var showPrepTimeSheet: Bool = false
    @Published var showIngredientsSheet: Bool = false
    @Published var filterServingCount: Int? = nil
    @Published var filterPrepTime: Int? = nil
    
    var isServingsHighlighted: Bool {
        filterServingCount != nil
    }
    
    var isPrepTimeHighlighted: Bool {
        filterPrepTime != nil
    }
    
    var isIngredientsHighlighted: Bool {
        !search.excludedIngredients.isEmpty || !search.includedIngredients.isEmpty
    }
    
    var shouldShowClearFilter: Bool {
        isServingsHighlighted || isPrepTimeHighlighted || search.vegetarianOnly == true || isIngredientsHighlighted
    }
    
    // For clear / reset
    private var allRecipes: [Recipe] = []
    
    init(service: RecipeService) {
        self.service = service
    }
    
    func load() async {
        await searchRecipes()
    }
    
    func searchRecipes() async {
        do {
            
            let result = try await service.searchRecipes(query: search)
            withAnimation {
                recipes = result
                // Save initial dataset once for reset
                if allRecipes.isEmpty {
                    allRecipes = result
                }
            }

        } catch {
            print(error)
        }
    }

    func searchTextChanged() {
        searchDebouncer.run { [weak self] in
            Task { await self?.searchRecipes() }
        }
    }
        
    func clearFilter() {
        withAnimation {
            search.vegetarianOnly = false
            filterServingCount = nil
            filterPrepTime = nil
            search.servings = nil
            search.maxPrepTime = nil
            search.excludedIngredients.removeAll()
            search.includedIngredients.removeAll()
            recipes = allRecipes
        }
        
    }
}
