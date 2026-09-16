//
//  HabitCard.swift
//  Habits
//
//  Created by Andrey on 04/05/2026.
//

import SwiftUI

struct HabitCard: View {
    
    @AppStorage private var statisticsDisplayMode: String
    
    private let habit: Habit
    
    private var displayMode: StatisticsDisplayMode {
        StatisticsDisplayMode(rawValue: statisticsDisplayMode) ?? .week
    }
    
    init(_ habit: Habit) {
        self.habit = habit
        
        self._statisticsDisplayMode = AppStorage(
            wrappedValue: StatisticsDisplayMode.week.rawValue,
            "statisticsDisplayMode_\(habit.id)"
        )
    }
    
    var body: some View {
        VStack(spacing: displayMode == .week ? 8.0 : 12.0) {
            CardHeader(habit)
            
            switch displayMode {
            case .week: WeekRowStats(habit: habit)
            case .month: MonthGridStats(habit)
            }
        }
        .padding(12)
        .background(defaultStyleShape(RoundedRectangle(cornerRadius: 24), isElevated: true))
    }
}

private extension HabitCard {
    enum StatisticsDisplayMode: String {
        case week
        case month
    }
}

#Preview {
    HabitCard(.init(emoji: "🌁", title: "Sample"))
        .padding(16.0)
}
