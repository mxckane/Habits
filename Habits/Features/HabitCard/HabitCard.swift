//
//  HabitCard.swift
//  Habits
//
//  Created by Andrey on 04/05/2026.
//

import SwiftUI

struct HabitCard: View {
    
    private let habit: Habit
    
    init(_ habit: Habit) {
        self.habit = habit
    }
    
    var body: some View {
        VStack(spacing: 8) {
            CardHeader(habit)
            MonthGridStats(habit)
        }
        .padding(12)
        .background(defaultStyleShape(RoundedRectangle(cornerRadius: 24), isElevated: true))
    }
}

#Preview {
    HabitCard(.init(emoji: "🌁", title: "Sample"))
        .padding(16.0)
}
