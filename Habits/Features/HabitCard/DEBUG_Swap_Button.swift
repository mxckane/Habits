//
//  DEBUG_Swap_Button.swift
//  Habits
//
//  Created by Andrey on 12/09/2026.
//

import SwiftUI

struct DEBUG_Swap_Button: View {
    
    let habit: Habit
    
    var body: some View {
        Button {
            let currentKey = UserDefaults.standard.string(forKey: "statisticsDisplayMode_\(habit.id)")
            let newModeRawValue = currentKey == "week" ? "month" : "week"
            UserDefaults.standard.setValue(newModeRawValue, forKeyPath: "statisticsDisplayMode_\(habit.id)")
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
        .geometryGroup()
    }
}
