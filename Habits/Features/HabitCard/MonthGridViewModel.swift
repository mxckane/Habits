//
//  MonthGridViewModel.swift
//  Habits
//
//  Created by Andrey on 03/09/2026.
//

import Foundation

struct MonthGridViewModel {
    let date: Date
    let habit: Habit
    let dayCount: Int
    let columnCount: Int
    let paddingCellCount: Int
    let validIndexRange: Range<Int>
    let monthName: String

    init(date: Date, habit: Habit) {
        self.date = date.leavingComponents([.calendar, .year, .month])
        self.habit = habit
        self.dayCount = date.count(of: .day, in: .month)
        self.columnCount = date.count(of: .weekOfMonth, in: .month)
        self.paddingCellCount = date.amountOfPaddingDays
        self.validIndexRange = paddingCellCount..<dayCount + paddingCellCount
        self.monthName = date.monthName(.wide)
    }
}
