//
//  FooterMetric.swift
//  Habits
//
//  Created by Andrey on 25/07/2026.
//

import SwiftUI

struct FooterMetric: Identifiable {
    let id = UUID()

    var header: String?
    var value: LocalizedStringResource?
    var imageSystemName: String?

    var metricToImageSpacing: CGFloat = 2.0
}
