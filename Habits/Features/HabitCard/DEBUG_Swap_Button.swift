//
//  DEBUG_Swap_Button.swift
//  Habits
//
//  Created by Andrey on 12/09/2026.
//

import SwiftUI

struct DEBUG_Swap_Button: View {
    
    // TODO: Beautify appearance
    
    let habit: Habit
    
    var body: some View {
        Button {
            let currentKey = UserDefaults.standard.string(forKey: "statisticsDisplayMode_\(habit.id)")
            let newModeRawValue = currentKey == "week" ? "month" : "week"
            UserDefaults.standard.setValue(newModeRawValue, forKeyPath: "statisticsDisplayMode_\(habit.id)")
        } label: {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(.accent)
                .frame(width: 52.0, height: 38.0)
                .overlay {
                    Image(systemName: "rectangle.2.swap")
                        .foregroundStyle(Color.background)
                        .font(.system(size: 12.0, weight: .medium))
                }
        }
        .geometryGroup()
    }
}
