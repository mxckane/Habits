//
//  HabitCard.swift
//  Habits
//
//  Created by Andrey on 04/05/2026.
//

import SwiftUI

struct HabitCard: View {
    
    @AppStorage("statisticsDisplayMode") private var statisticsDisplayMode = StatisticsDisplayMode.week.rawValue
    
    private var displayMode: StatisticsDisplayMode {
        StatisticsDisplayMode(rawValue: statisticsDisplayMode) ?? .week
    }
    
    private let habit: Habit
    
    init(_ habit: Habit) {
        self.habit = habit
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
