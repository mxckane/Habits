//
//  DefaultStyleShape.swift
//  Habits
//
//  Created by Andrey on 24/09/2026.
//

import SwiftUI

struct DefaultStyleShape<S: InsettableShape>: View {
    private let shape: S
    private let hasStroke: Bool
    private let isElevated: Bool

    init(_ shape: S, hasStroke: Bool = true, isElevated: Bool = false) {
        self.shape = shape
        self.hasStroke = hasStroke
        self.isElevated = isElevated
    }

    var body: some View {
        shape.applyDefaultStyling(hasStroke: hasStroke, isElevated: isElevated)
    }
}

#Preview {
    VStack(spacing: 38) {
        RoundedRectangle(cornerRadius: 36)
            .applyDefaultStyling()
            .frame(width: 128, height: 128)

        RoundedRectangle(cornerRadius: 36)
            .applyDefaultStyling(isElevated: true)
            .frame(width: 128, height: 128)
    }
}
