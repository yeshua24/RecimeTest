//
//  FilterIngredientsView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import SwiftUI
import SwiftUI

struct FilterIngredientsView: View {

    let onApply: (_ included: Set<String>, _ excluded: Set<String>) -> Void

    @StateObject private var vm: IngredientFilterViewModel
    @Environment(\.dismiss) private var dismiss

    @AppStorage("hasShownIngredientInstruction")
    private var hasShownInstruction: Bool = false

    init(
        ingredients: [Ingredient],
        included: Set<String> = [],
        excluded: Set<String> = [],
        onApply: @escaping (_ included: Set<String>, _ excluded: Set<String>) -> Void
    ) {
        _vm = StateObject(
            wrappedValue: IngredientFilterViewModel(
                ingredients: ingredients,
                included: included,
                excluded: excluded
            )
        )
        self.onApply = onApply
    }

    var body: some View {
        VStack(spacing: 0) {

            IngredientFilterHeader(
                onClose: { dismiss() },
                onApply: {
                    onApply(vm.included, vm.excluded)
                    dismiss()
                }
            )

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    if !vm.included.isEmpty {
                        IngredientSectionView(
                            title: "Included Recipe",
                            items: Array(vm.included),
                            state: .included
                        ) { vm.included.remove($0) }
                    }

                    if !vm.excluded.isEmpty {
                        IngredientSectionView(
                            title: "Excluded Recipe",
                            items: Array(vm.excluded),
                            state: .excluded
                        ) { vm.excluded.remove($0) }
                    }

                    popularSection
                }
                .padding()
            }
        }
        .overlay {
            IngredientFilterInstructionOverlay(
                isVisible: .constant(!hasShownInstruction)
            )
        }
    }

    private var popularSection: some View {
        let grid = Array(repeating: GridItem(.flexible()), count: 4)

        return VStack(alignment: .leading, spacing: 12) {

            Text("Popular")
                .font(.headline)

            LazyVGrid(columns: grid, spacing: 20) {
                ForEach(vm.filteredIngredients) { ingredient in
                    IngredientCell(
                        ingredient: ingredient,
                        state: vm.state(for: ingredient),
                        isMainList: true
                    ) {
                        vm.tap(ingredient)
                    } onLongPress: {
                        vm.longPress(ingredient)
                    }
                }
            }
        }
    }
}
