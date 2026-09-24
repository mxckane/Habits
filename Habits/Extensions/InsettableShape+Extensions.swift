//
//  InsettableShape+Extensions.swift
//  Habits
//
//  Created by Andrey on 29/04/2026.
//

import SwiftUI

extension InsettableShape {
    func applyDefaultStyling(hasStroke: Bool = true, isElevated: Bool = false) -> some View {
        self
            .fill(isElevated ? .shapeElevated : .shape)
            .overlay {
                if hasStroke {
                    StrokeBorderShapeView(
                        shape: self,
                        style: .habitCardStroke,
                        strokeStyle: .init(lineWidth: 1),
                        isAntialiased: true,
                        background: Color.clear
                    )
                }
            }
            .shadow(color: .shapeShadow, radius: 14, y: 4)
    }
}
