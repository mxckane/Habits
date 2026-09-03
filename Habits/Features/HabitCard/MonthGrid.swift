//
//  MonthGrid.swift
//  Habits
//
//  Created by Andrey on 28/08/2026.
//

import SwiftUI
import SwiftData

struct MonthGrid: View {
    
    @Query private var records: [Record]
    
    private let model: MonthGridViewModel
    
    init(_ model: MonthGridViewModel) {
        self.model = model
        
        let habitID = model.habit.id
        let timeInterval = model.monthDate.interval(of: .month)
        let predicate = #Predicate<Record> { record in
            record.habit?.id == habitID
            && record.timestamp >= timeInterval.start
            && record.timestamp < timeInterval.end
        }
        
        self._records = Query(filter: predicate)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(model.monthName)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .font(.footnote)
                .fontWeight(.bold)
                .frame(height: 18.0)
            Grid(horizontalSpacing: 2.0, verticalSpacing: 2.0) {
                ForEach(0..<7) { row in
                    GridRow {
                        ForEach(0..<model.columnsCount, id: \.self) { column in
                            let index = row + column * 7
                            
                            let date = Calendar.current.date(
                                byAdding: .day,
                                value: index - model.paddingCellsCount,
                                to: model.monthDate
                            )!
                            
                            if !model.validIndexRange.contains(index) {
                                Mark(state: .placeholder)
                            } else if records.contains(where: { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }) {
                                Mark(state: .checked)
                            } else if date.isToday {
                                Mark(state: .today)
                            } else {
                                Mark(state: .unchecked)
                            }
                        }
                    }
                    .frame(maxWidth: model.cellSize)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var offset = 0
    let habit = Habit(emoji: "🌁", title: "Sample")
    
    var date: Date {
        Calendar.current.date(byAdding: .month, value: offset, to: .now)!
    }
    
    var stepperText: String {
        "\(date.formatted(.dateTime.month(.wide))) \(date.formatted(.dateTime.year()))"
    }
    
    var model: MonthGridViewModel {
        MonthGridViewModel(cellSize: 22.0, date: date, habit: habit)
    }
    
    VStack(spacing: 32.0) {
        MonthGrid(model)
        Stepper(stepperText, value: $offset)
            .frame(width: 240.0)
    }
}
