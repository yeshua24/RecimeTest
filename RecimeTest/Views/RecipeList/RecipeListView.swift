//
//  RecipeListView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import SwiftUI

struct RecipeListView: View {

    @StateObject var viewModel: RecipeListViewModel
    @Namespace private var searchNamespace
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 16) {

                    filtersSection

                    if viewModel.recipes.isEmpty {
                        Image("NoResult")
                            .padding(.top, 40)
                    } else {
                        RecipeGridView(recipes: viewModel.recipes)
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationSubtitle("^[\(viewModel.recipes.count) Recipe](inflect: true)")
            .navigationDestination(for: Recipe.self) {
                RecipeDetailView(recipe: $0)
            }
        }
        .sheet(isPresented: $viewModel.showServingsSheet) {
            servingsSheet
        }
        .sheet(isPresented: $viewModel.showPrepTimeSheet) {
            prepTimeSheet
        }
        .sheet(isPresented: $viewModel.showIngredientsSheet) {
            ingredientsSheet
        }
        .onAppear {
            Task { await viewModel.load() }
        }
    }
}

// MARK: - Filters Section

private extension RecipeListView {

    var filtersSection: some View {
        VStack {

            if viewModel.isSearching {
                RecipeSearchBar(
                    text: $viewModel.search.keyword,
                    isSearching: $viewModel.isSearching,
                    isFocused: $isSearchFocused
                ) {
                    viewModel.searchTextChanged()
                }
                .matchedGeometryEffect(id: "searchBar", in: searchNamespace)
                .padding(.horizontal)
                .padding(.bottom, 12)
            }

            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {

                        if !viewModel.isSearching {
                            FilterChipView(leftIcon: "magnifyingglass", action: {
                                withAnimation {
                                    viewModel.isSearching.toggle()
                                }
                            })
                            .matchedGeometryEffect(id: "searchBar", in: searchNamespace)
                        }

                        FilterChipView(
                            isSelected: $viewModel.search.vegetarianOnly,
                            leftIcon: "leaf.fill",
                            title: "Vegetarian"
                        ) { Task { await viewModel.searchRecipes() } }

                        FilterChipView(
                            isSelected: .constant(viewModel.isIngredientsHighlighted),
                            leftIcon: "list.bullet",
                            title: "Ingredients",
                            isShowDropdown: true
                        ) { viewModel.showIngredientsSheet.toggle() }

                        FilterChipView(
                            isSelected: .constant(viewModel.isServingsHighlighted),
                            leftIcon: "person.2",
                            title: "Servings",
                            isShowDropdown: true
                        ) { viewModel.showServingsSheet.toggle() }

                        FilterChipView(
                            isSelected: .constant(viewModel.isPrepTimeHighlighted),
                            leftIcon: "clock",
                            title: "Prep Time",
                            isShowDropdown: true
                        ) { viewModel.showPrepTimeSheet.toggle() }

                        if viewModel.shouldShowClearFilter {
                            Button("Clear filter") {
                                viewModel.clearFilter()
                            }
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color("AppOrange"))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 10)
    }
}

// MARK: - Sheets

private extension RecipeListView {

    var servingsSheet: some View {
        FilterSheetView(
            title: "Servings",
            options: [
                .init(display: "Any", value: nil),
                .init(display: "For 1 serving", value: 1),
                .init(display: "For 2 servings", value: 2),
                .init(display: "For 3 servings", value: 3),
                .init(display: "For 4 servings", value: 4)
            ],
            selectedValue: viewModel.filterServingCount
        ) { value in
            withAnimation {
                viewModel.filterServingCount = value
                viewModel.search.servings = value
                Task { await viewModel.searchRecipes() }
            }
        }
    }

    var prepTimeSheet: some View {
        FilterSheetView(
            title: "Prep Time",
            options: [
                .init(display: "Any", value: nil),
                .init(display: "Under 15 mins", value: 15),
                .init(display: "Under 30 mins", value: 30),
                .init(display: "Under 60 mins", value: 60),
            ],
            selectedValue: viewModel.filterPrepTime
        ) { value in
            withAnimation {
                viewModel.filterPrepTime = value
                viewModel.search.maxPrepTime = value
                Task { await viewModel.searchRecipes() }
            }
        }
    }

    var ingredientsSheet: some View {
        FilterIngredientsView(
            ingredients: Ingredient.mock,
            included: viewModel.search.includedIngredients,
            excluded: viewModel.search.excludedIngredients
        ) { included, excluded in
            viewModel.search.includedIngredients = included
            viewModel.search.excludedIngredients = excluded
            Task { await viewModel.searchRecipes() }
        }
    }
}

// MARK: - Preview

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(service: RecipeService())
    )
}
