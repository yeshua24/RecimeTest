//
//  Int+Extensions.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/15/26.
//

import Foundation

extension Int {

    var hoursMinutesText: String {
        let hours = self / 60
        let minutes = self % 60

        if hours > 0 && minutes > 0 {
            return "\(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours)h"
        } else {
            return "\(minutes)m"
        }
    }
}
