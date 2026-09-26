//
//  StreakButton.swift
//  Habits
//
//  Created by Andrey on 04/05/2026.
//

import SwiftData
import SwiftUI

struct StreakButton: View {
    @Query private var records: [Record]

    private let habit: Habit

    private let calendar = Calendar.current

    private var todayRecord: Record? {
        records.first { calendar.isDate($0.timestamp, inSameDayAs: .now) }
    }

    private var isTodayChecked: Bool {
        todayRecord != nil
    }

    private var streak: Int {
        guard !records.isEmpty else {
            return 0
        }

        var count = 0
        var dateToCheck = Date.startOfToday
        let recordDates = Set(records.map { calendar.startOfDay(for: $0.timestamp) })

        if !recordDates.contains(dateToCheck) {
            dateToCheck = calendar.date(byAdding: .day, value: -1, to: .startOfToday)!
        }

        while recordDates.contains(dateToCheck) {
            count += 1
            dateToCheck = calendar.date(byAdding: .day, value: -1, to: dateToCheck)!
        }

        return count
    }

    init(habit: Habit) {
        self.habit = habit

        let fetchedRecordsHabitID = habit.persistentModelID

        let predicate = #Predicate<Record> { record in
            record.habit?.persistentModelID == fetchedRecordsHabitID
        }

        self._records = Query(filter: predicate, sort: \.timestamp)
    }

    var body: some View {
        Button {
            if let todayRecord {
                DataManager.shared.delete(todayRecord)
            } else {
                let newRecord = Record(habit: habit)
                DataManager.shared.insert(newRecord)
            }
        } label: {
            HStack(spacing: 2.0) {
                Image(systemName: "bolt.fill")
                Text(String(streak))
            }
            .foregroundStyle(isTodayChecked ? .labelPrimary : .accentPrimary)
            .font(.system(size: 17.0))
            .fontWeight(.semibold)
            .padding(8.0)
            .frame(height: 38.0)
            .background(isTodayChecked ? .accentPrimary : .clear, in: RoundedRectangle(cornerRadius: 12.0))
        }
    }
}

#Preview {
    let habit = Habit(emoji: "🎯", title: "Preview Habit")

    StreakButton(habit: habit)
        .modelContainer(DataManager.shared.container)
}
