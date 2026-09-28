//
//  WeekRowStats.swift
//  Habits
//
//  Created by Andrey on 28/05/2026.
//

import SwiftData
import SwiftUI

struct WeekRowStats: View {
    @Query private var records: [Record]

    @State private var markHeight: CGFloat?

    private let habit: Habit

    private var dates = {
        let startOfCurrentWeek = Calendar.current.dateInterval(of: .weekOfYear, for: .now)!.start
        let weekRowLastDate = Calendar.current.date(byAdding: .day, value: 6, to: startOfCurrentWeek)!

        return (0..<10).reversed().map { index in
            Calendar.current.date(byAdding: .day, value: -index, to: weekRowLastDate)!
        }
    }()

    init(habit: Habit) {
        self.habit = habit

        let fetchedRecordsHabitID = habit.persistentModelID
        let predicate = #Predicate<Record> { $0.habit?.persistentModelID == fetchedRecordsHabitID }

        _records = Query(filter: predicate, sort: \.timestamp)
    }

    var body: some View {
        HStack(spacing: 8.0) {
            ForEach(
                Array(dates.enumerated()), id: \.offset
            ) { index, date in
                weekRowCell(
                    date: date,
                    hasRecord: records.contains { record in
                        Calendar.current.isDate(record.timestamp, equalTo: date, toGranularity: .day)
                    },
                    isToday: date.isToday
                )
                if index == 2 {
                    separatorColumn()
                }
            }
        }
    }

    @ViewBuilder private func weekRowCell(date: Date, hasRecord: Bool, isToday: Bool) -> some View {
        let state: Mark.State = hasRecord ? .checked : isToday ? .today : .unchecked
        let symbol = date.formatted(.dateTime.weekday(.narrow))

        VStack(spacing: 4.0) {
            Mark(state: state)
                .readSize(.vertical, into: $markHeight)
            Text(symbol)
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 9.0))
                .fontWeight(.semibold)
                .frame(height: 16.0)
        }
        .contentShape(.rect)
        .onTapGesture {
            ModalManager.shared.present(.habitCalendarSheet(habit, date))
        }
    }

    private func separatorColumn() -> some View {
        VStack(spacing: 4.0) {
            Capsule()
                .fill(.accentSecondary)
                .padding(.vertical, 1.5)
                .frame(width: 1.0, height: markHeight)
            Capsule()
                .fill(.accentSecondary)
                .frame(width: 1.0, height: 16.0)
        }
    }
}
