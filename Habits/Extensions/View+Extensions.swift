//
//  View+Extensions.swift
//  Habits
//
//  Created by Andrey on 28/04/2026.
//

import Combine
import SwiftUI

extension View {
    func modalPresenter() -> some View {
        modifier(ModalPresenter())
    }

    /// Applies a glass effect to this view.
    @ViewBuilder
    func glassEffect(
        isClear: Bool = false,
        isInteractive: Bool = false,
        tint: Color? = nil,
        in shape: some Shape = Capsule()
    ) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            let glass = (isClear ? Glass.clear : Glass.regular)
                .interactive(isInteractive)
                .tint(tint)

            self.glassEffect(glass, in: shape)
        } else {
            self
        }
    }

    /// Applies a glass effect with a custom fallback.
    @ViewBuilder
    func glassEffect<Fallback: View>(
        isClear: Bool = false,
        isInteractive: Bool = false,
        tint: Color? = nil,
        in shape: some Shape = Capsule(),
        @ViewBuilder fallbackView: (Self) -> Fallback
    ) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            let glass = (isClear ? Glass.clear : Glass.regular)
                .interactive(isInteractive)
                .tint(tint)

            self.glassEffect(glass, in: shape)
        } else {
            fallbackView(self)
        }
    }

    func defaultStyleShape<S: InsettableShape>(
        _ shape: S,
        hasStroke: Bool = true,
        isElevated: Bool = false
    ) -> some View {
        shape.applyDefaultStyling(hasStroke: hasStroke, isElevated: isElevated)
    }

    func readSize(_ dimension: Axis.Set, into property: Binding<CGFloat>) -> some View {
        self.onGeometryChange(for: CGFloat.self) { geometry in
            dimension == .horizontal ? geometry.size.width : geometry.size.height
        } action: { size in
            property.wrappedValue = size
        }
    }

    func receiveKeyboardPresentationState(_ state: Binding<Bool>) -> some View {
        let willShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }

        let willHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }

        let publisher = Publishers.Merge(willShow, willHide)

        return self.onReceive(publisher) { output in
            state.wrappedValue = output
        }
    }
}
