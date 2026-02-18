//
//  RecipeDetailView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import SwiftUI

struct RecipeDetailView: View {

    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                HeroImage(url: recipe.imageUrl)

                VStack(alignment: .leading, spacing: 20) {
                    titleSection
                    descriptionSection
                    ingredientsSection
                    instructionsSection
                }
                .padding()
            }
        }
        .coordinateSpace(name: "scroll")
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Sections
private extension RecipeDetailView {

    var titleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(recipe.title)
                .font(.largeTitle.weight(.bold))

            HStack(spacing: 16) {
                Label("\(recipe.servings) servings", systemImage: "person.2")
                Label(recipe.prepTime.hoursMinutesText, systemImage: "clock")

                Spacer()

                if recipe.isVegetarian {
                    DietBadge(text: "Vegetarian")
                }
            }
        }
    }

    var descriptionSection: some View {
        Text(recipe.description)
    }

    var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Ingredients")
            ForEach(recipe.ingredients, id: \.self) {
                BulletRow(text: $0)
            }
        }
    }

    var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Instructions")
            ForEach(recipe.instructions.indices, id: \.self) { index in
                NumberedRow(number: index + 1, text: recipe.instructions[index])
            }
        }
    }
}

// MARK: - Components

private struct HeroImage: View {

    let url: String

    var body: some View {
        GeometryReader { proxy in

            let minY = proxy.frame(in: .named("scroll")).minY
            let height = proxy.size.height

            CachedAsyncImage(url: URL(string: url))
            .scaledToFill()
            .frame(
                width: proxy.size.width,
                height: minY > 0 ? height + minY : height
            )
            .clipped()
            .offset(y: minY > 0 ? -minY : 0)
        }
        .frame(height: 300)
    }
}

private struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2.weight(.bold))
            .foregroundStyle(Color("AppOrange"))
    }
}

private struct BulletRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
            Text(text)
        }
    }
}

private struct NumberedRow: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("\(number).")
                .bold()
            Text(text)
        }
    }
}

private struct DietBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule().fill(Color.green.opacity(0.15))
            )
            .foregroundStyle(.green)
    }
}

#Preview {
    RecipeDetailView(recipe: .mock)
}
