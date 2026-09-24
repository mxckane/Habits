//
//  WeekRowStats.swift
//  Habits
//
//  Created by Andrey on 28/05/2026.
//

import SwiftData
import SwiftUI

// MARK: Try using computed property Habit.records instead of query

struct WeekRowStats: View {
    private let habit: Habit

    @Query private var records: [Record]

    @State private var markHeight: CGFloat = 0.0

    private var datesRange: [Date] = {
        var dates: [Date] = []
        let startOfCurrentWeek = Calendar.current.dateInterval(of: .weekOfYear, for: .now)!.start
        let weekRowLastDate = Calendar.current.date(byAdding: .day, value: 6, to: startOfCurrentWeek)!

        (0..<10).reversed().forEach { index in
            let dateToAdd = Calendar.current.date(byAdding: .day, value: -index, to: weekRowLastDate)!
            dates.append(dateToAdd)
        }

        return dates
    }()

    init(habit: Habit) {
        self.habit = habit

        let fetchedRecordsHabitID = habit.persistentModelID
        let predicate = #Predicate<Record> { $0.habit?.persistentModelID == fetchedRecordsHabitID }

        _records = Query(filter: predicate, sort: \.timestamp)
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(
                Array(datesRange.enumerated()), id: \.offset
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

        VStack(spacing: 4) {
            Mark(state: state)
                .readSize(.vertical, into: $markHeight)
            Text(symbol)
                .frame(height: 14)
                .foregroundStyle(.accent)
                .font(.system(size: 10, weight: .bold))
        }
        .contentShape(.rect)
        .onTapGesture {
            ModalManager.shared.present(.habitCalendarSheet(habit, date))
        }
    }

    private func separatorColumn() -> some View {
        VStack(spacing: 4) {
            Capsule()
                .fill(.weekRowSeparator)
                .padding(.vertical, 2)
                .frame(width: 1.5, height: markHeight)
            Capsule()
                .fill(.weekRowSeparatorSecondary)
                .frame(width: 1.5, height: 14)
        }
    }
}
