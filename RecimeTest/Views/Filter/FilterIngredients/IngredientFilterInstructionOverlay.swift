//
//  IngredientFilterInstructionOverlayswift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation
import SwiftUI

struct IngredientFilterInstructionOverlay: View {

    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            VStack {
                Spacer()

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("AppOrange"))
                    .frame(height: 40)
                    .padding()
                    .overlay {
                        Text("Okay, got it!")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .onTapGesture {
                        withAnimation { isVisible = false }
                    }
            }
            .background(Color.black.opacity(0.7))
        }
    }
}
