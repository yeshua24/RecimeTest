//
//  Debouncer.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation

final class Debouncer {

    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func run(action: @escaping () -> Void) {
        workItem?.cancel()

        let item = DispatchWorkItem(block: action)
        workItem = item

        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }
}
