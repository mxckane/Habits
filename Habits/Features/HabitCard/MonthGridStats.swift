//
//  MonthGridStats.swift
//  Habits
//
//  Created by Andrey on 05/08/2026.
//

import SwiftUI

// TODO: Review

// TODO: Update styling AMEND

struct MonthGridStats: View {
    private let monthGridViewModels: [MonthGridViewModel]

    @State private var availableWidth: CGFloat?
    private let columnCount: Int
    private let cellSpacing: CGFloat
    private let gridCount: Int
    private let gridSpacing: CGFloat = 8.0

    private var cellSize: CGFloat {
        let cellsWidth = CGFloat(columnCount - gridCount) * cellSpacing
        let gridsWidth = CGFloat(gridCount - 1) * gridSpacing
        if let availableWidth {
            return (availableWidth - cellsWidth - gridsWidth) / CGFloat(columnCount)
        }
        return .zero
    }

    init(_ habit: Habit) {
        let currentMonthDate = Date.now.leavingComponents([.calendar, .year, .month])

        self.monthGridViewModels = (-2...0).map { offset in
            let date = Calendar.current.date(byAdding: .month, value: offset, to: currentMonthDate)!
            return MonthGridViewModel(date: date, habit: habit)
        }
        self.columnCount = monthGridViewModels.reduce(0) { $0 + $1.columnCount }
        self.cellSpacing = monthGridViewModels.first?.cellSpacing ?? 0.0
        self.gridCount = monthGridViewModels.count
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 4.0) {
            weekdaysColumn(cellHeight: cellSize)
            HStack(spacing: gridSpacing) {
                ForEach(monthGridViewModels, id: \.date) { model in
                    MonthGrid(cellSize: cellSize, model: model)
                }
            }
            .frame(maxWidth: .infinity)
            .readSize(.horizontal, into: $availableWidth)
        }
    }

    @ViewBuilder func weekdaysColumn(cellHeight: CGFloat) -> some View {
        let symbols = Calendar.current.veryShortWeekdaySymbols
        let systemFirstWeekdayIndex = Calendar.current.firstWeekday - 1
        var weekDays: [String] {
            Array(symbols[systemFirstWeekdayIndex...]) + Array(symbols[..<systemFirstWeekdayIndex])
        }

        VStack(spacing: cellSpacing) {
            ForEach(0..<weekDays.count, id: \.self) { index in
                Text(symbols[index])
                    .foregroundStyle(.accent)
                    .font(.system(size: 9.0))
                    .fontWeight(.semibold)
                    .frame(width: 16.0, height: cellHeight)
            }
        }
        .padding(.trailing, 2.0)
        .overlay(alignment: .trailing) {
            Capsule()
                .fill(.monthGridStatsWeekdaysColumnSeparator)
                .frame(width: 1.0)
        }
    }
}

#Preview {
    HabitCard(.init(emoji: "🌁", title: "Sample"))
        .padding(16.0)
}
