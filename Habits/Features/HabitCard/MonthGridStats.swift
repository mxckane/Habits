//
//  MonthGridStats.swift
//  Habits
//
//  Created by Andrey on 05/08/2026.
//

import SwiftUI

struct MonthGridStats: View {
    
    private let habit: Habit
    private let monthGridViewModels: [MonthGridViewModel]
    
    @State private var availableWidth: CGFloat = 0.0
    private let columnCount: Int
    private let cellSpacing: CGFloat
    private let gridCount: Int
    private let gridSpacing: CGFloat = 8.0
    
    private var cellSize: CGFloat {
        let cellsWidth = CGFloat(columnCount - gridCount) * cellSpacing
        let gridsWidth = CGFloat(gridCount - 1) * gridSpacing
        return (availableWidth - cellsWidth - gridsWidth) / CGFloat(columnCount)
    }
    
    init(_ habit: Habit) {
        let currentMonthDate = Date.now.leavingComponents([.calendar, .year, .month])
        
        self.habit = habit
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
            HStack(spacing: gridSpacing) {
                ForEach(monthGridViewModels, id: \.date) { model in
                    MonthGrid(cellSize: cellSize, model: model)
                        .border(.yellow.opacity(1/2))
                }
            }
            .frame(maxWidth: .infinity)
            .border(.green.opacity(1/2))
            .readSize(.horizontal, into: $availableWidth)
        }
    }
    
}

#Preview {
    HabitCard(.init(emoji: "🌁", title: "Sample"))
        .padding(16.0)
}
