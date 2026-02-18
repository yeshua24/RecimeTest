//
//  IngredientFilterHeaderView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI

struct IngredientFilterHeader: View {

    let onClose: () -> Void
    let onApply: () -> Void

    var body: some View {
        HStack {
            Button("✕", action: onClose)
                .tint(.black)

            Spacer()

            Text("Filter by ingredients")
                .font(.headline)

            Spacer()

            Button("Apply", action: onApply)
                .tint(.black)
        }
        .padding(30)
    }
}
