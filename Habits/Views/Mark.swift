//
//  Mark.swift
//  Habits
//
//  Created by Andrey on 06/08/2026.
//

import SwiftUI

struct Mark: View {
    let state: State
    let size: CGFloat?
    let colors: [Color]
    let cornerRadiusCoefficient: CGFloat

    enum State {
        case placeholder
        case unchecked
        case today
        case checked
    }

    init(state: State = .unchecked) {
        self.state = state

        self.size = switch state {
        case .placeholder: 0.0
        case .unchecked: 4.0
        case .today: 8.0
        case .checked: nil
        }

        self.colors = switch state {
        case .placeholder: [.clear]
        case .unchecked: [.weekRowEmptyCell]
        case .today, .checked: [.weekRowCellStart, .weekRowCellEnd]
        }

        self.cornerRadiusCoefficient = switch state {
        case .checked: .markCornerRadiusCoefficient
        default: 0.5
        }
    }

    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: proxy.size.width * cornerRadiusCoefficient)
                .fill(colors.gradient)
                .frame(width: size, height: size)
                .position(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .animation(.spring(duration: state == .checked ? 0.375 : 0.475, bounce: 0.425), value: state)
    }
}

#Preview {
    VStack(spacing: 0.0) {
        Mark(state: .placeholder)
        Mark(state: .unchecked)
        Mark(state: .today)
        Mark(state: .checked)
    }
    .frame(height: 160.0)
}
