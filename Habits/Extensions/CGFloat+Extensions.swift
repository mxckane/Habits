//
//  CGFloat+Extensions.swift
//  Habits
//
//  Created by Andrey on 15/05/2026.
//

import SwiftUI

extension CGFloat {
    static let markCornerRadiusCoefficient: CGFloat = 0.34375

    static var displayCornerRadius: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return 0
        }
        return windowScene.screen.value(forKey: "_displayCornerRadius") as? CGFloat ?? 0
    }
}
