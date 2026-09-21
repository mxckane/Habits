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
    
    func modify(@ViewBuilder _ transform: (_ view: Self) -> some View) -> some View {
        transform(self)
    }
    
    // TODO: Rewrite
    @ViewBuilder public func glassEffect(
        isEnabled: Bool = true,
        isInteractive: Bool = false,
        isClear: Bool = true,
        tint: Color? = nil,
        in shape: some Shape = Circle(),
        else otherView: (Self) -> some View
    ) -> some View {
        if #available(anyAppleOS 26.0, *) {
            let effect: Glass = if isEnabled {
                if isClear {
                    .clear.interactive(isInteractive).tint(tint)
                } else {
                    .regular.interactive(isInteractive).tint(tint)
                }
            } else {
                .identity
            }
            
            glassEffect(effect, in: shape)
        } else {
            otherView(self)
        }
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
