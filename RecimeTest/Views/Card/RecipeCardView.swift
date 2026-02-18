//
//  RecipeCardView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/13/26.
//

import SwiftUI

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CachedAsyncImage(url: URL(string: recipe.imageUrl))
            .scaledToFill()
            .frame(height: 150)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    topTrailingRadius: 12
                )
            )
            .clipped()
            

            Text(recipe.title)
                .lineLimit(1)
                .font(.system(size: 14, weight: .medium))
                .padding(10)
                .offset(y: -4)

        }
      
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

#Preview {
    RecipeCardView(recipe: .mock)
}
