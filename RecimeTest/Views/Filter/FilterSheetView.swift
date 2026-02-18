//
//  FilterSheetView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import Foundation
import SwiftUI

struct FilterOption {
    let id = UUID()
    let display: String
    let value: Int?
}

struct FilterSheetView: View {

    let title: String
    let options: [FilterOption]
    @State var selectedValue: Int?
    let onApply: (Int?) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            Text(title)
                .font(.headline)
                .padding()
                .padding(.top, 20)
            Divider()

            VStack(spacing: 0) {
                ForEach(options, id: \.id) { option in
                    Button {
                        withAnimation {
                            selectedValue = option.value
                        }
                    } label: {
                        HStack {
                            Text(option.display)
                                .foregroundStyle(.primary)
                            Spacer()
                            Circle()
                                .stroke(Color.secondary, lineWidth: 1)
                                .frame(width: 22, height: 22)
                                .overlay {
                                    if selectedValue == option.value {
                                        Circle()
                                            .fill(Color.primary)
                                            .frame(width: 12, height: 12)
                                    }
                                }
                        }
                        .padding()
                    }
                    .tint(.black)
                    

                    Divider()
                }
            }

            Spacer()

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondary.opacity(0.2))
                .overlay {
                    Text("Apply")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                .frame(height: 50)
                .onTapGesture {
                    onApply(selectedValue)
                    dismiss()
                }
            .padding()
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(Color.white)
    }
}

#Preview {
    FilterSheetView(
        title: "Total Time",
        options: [
            FilterOption(display: "Under 15 mins", value: 15),
            FilterOption(display: "Under 30 mins", value: 30),
            FilterOption(display: "Under 60 mins", value: 60)
        ],
        selectedValue: nil
    ) { _ in }
}
