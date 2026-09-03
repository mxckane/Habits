//
//  MonthGridViewModel.swift
//  Habits
//
//  Created by Andrey on 03/09/2026.
//

import Foundation

struct MonthGridViewModel {
    let cellSize: CGFloat?
    let monthDate: Date
    let habit: Habit
    let daysCount: Int
    let columnsCount: Int
    let paddingCellsCount: Int
    let validIndexRange: Range<Int>
    let monthName: String
    
    init(cellSize: CGFloat?, date: Date, habit: Habit) {
        self.cellSize = cellSize
        self.monthDate = date.leavingComponents([.calendar, .year, .month])
        self.habit = habit
        self.daysCount = monthDate.count(of: .day, in: .month)
        self.columnsCount = monthDate.count(of: .weekOfMonth, in: .month)
        self.paddingCellsCount = monthDate.amountOfPaddingDays
        self.validIndexRange = paddingCellsCount..<daysCount+paddingCellsCount
        self.monthName = date.monthName(.wide)
    }
}
