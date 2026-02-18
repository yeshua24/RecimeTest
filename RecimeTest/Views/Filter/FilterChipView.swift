//
//  FilterChipView.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import Foundation
import SwiftUI

struct FilterChipView: View {

    private let isSelected: Binding<Bool>?

    let leftIcon: String?
    var title: String = ""
    let isShowDropdown: Bool
    let action: (() -> Void)?

    init(
        isSelected: Binding<Bool>? = nil,
        leftIcon: String? = nil,
        title: String = "",
        isShowDropdown: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.isSelected = isSelected
        self.leftIcon = leftIcon
        self.title = title
        self.isShowDropdown = isShowDropdown
        self.action = action
    }

    private var selected: Bool {
        isSelected?.wrappedValue ?? false
    }

    var body: some View {

        Button {
            if let isSelected {
                isSelected.wrappedValue.toggle()
            }
            action?()
        } label: {
            HStack(spacing: 6) {

                if let leftIcon {
                    Image(systemName: leftIcon)
                        .font(.system(size: 9, weight: .medium))
                }

                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 13, weight: .medium))
                }

                if isShowDropdown {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8, weight: .semibold))
                }
            }
            .foregroundStyle(isSelected != nil && selected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(
                        isSelected != nil && selected
                        ? Color("AppOrange")
                        : Color(.white)
                    )
            )
            .overlay(
                Capsule()
                    .stroke(
                        isSelected != nil && selected
                        ? Color("AppOrange")
                        : Color(.systemGray4),
                        lineWidth: 1
                    )
            )
            .animation(.easeInOut(duration: 0.15), value: selected)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews

#Preview("Default") {
    FilterChipView(
        leftIcon: "leaf.fill",
        title: "Vegetarian",
        isShowDropdown: true
    ) {
        print("Tapped")
    }
    .padding()
}

#Preview("Selected") {
    StatefulPreviewWrapper(true) { binding in
        FilterChipView(
            isSelected: binding,
            leftIcon: "leaf.fill",
            title: "Vegetarian",
            isShowDropdown: true
        ) {
        }
        .padding()
    }
}

private struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
