//
//  DEBUG_Swap_Button.swift
//  Habits
//
//  Created by Andrey on 12/09/2026.
//

import SwiftUI

struct DEBUG_Swap_Button: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color(cgColor: .init(gray: 0.4, alpha: 1.0)))
                .frame(width: 48.0, height: 24.0)
                .overlay {
                    Image(systemName: "rectangle.2.swap")
                        .foregroundStyle(.accent)
                        .font(.system(size: 12.0, weight: .medium))
                }
        }
    }
}
