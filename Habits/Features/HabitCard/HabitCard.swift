//
//  HabitCard.swift
//  Habits
//
//  Created by Andrey on 04/05/2026.
//

import SwiftUI

struct HabitCard: View {
    @AppStorage private var statisticsDisplayMode: String

    private var displayMode: StatisticsDisplayMode? {
        StatisticsDisplayMode(rawValue: statisticsDisplayMode)
    }

    private let habit: Habit

    init(_ habit: Habit) {
        self.habit = habit

        self._statisticsDisplayMode = AppStorage(
            wrappedValue: StatisticsDisplayMode.week.rawValue,
            "statisticsDisplayMode_\(habit.id)"
        )
    }

    var body: some View {
        VStack(spacing: 8.0) {
            CardHeader(habit: habit)
            switch displayMode {
            case .week: WeekRowStats(habit: habit)
            case .month: MonthGridStats(habit)
            default: MissingStatsView()
            }
        }
        .padding(12.0)
        .background {
            RoundedRectangle(cornerRadius: 24.0)
                .fill(.backgroundSecondary)
                .shadow(color: .black.opacity(0.125), radius: 20.0, x: 0.0, y: 4.0)
        }
    }
}

extension HabitCard {
    enum StatisticsDisplayMode: String {
        case week
        case month
    }
}

#Preview {
    HabitCard(.sample)
        .padding(.horizontal, 16.0)
}
