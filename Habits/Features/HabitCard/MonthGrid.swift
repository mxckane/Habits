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
    
    private let cellSize: CGFloat
    private let model: MonthGridViewModel
    
    init(cellSize: CGFloat, model: MonthGridViewModel) {
        let habitID = model.habit.id
        let timeInterval = model.date.interval(of: .month)
        let predicate = #Predicate<Record> { record in
            record.habit?.id == habitID
            && record.timestamp >= timeInterval.start
            && record.timestamp < timeInterval.end
        }
        
        self._records = Query(filter: predicate)
        self.cellSize = cellSize
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(model.monthName)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .font(.footnote)
                .fontWeight(.bold)
                .frame(height: 18.0)
            Grid(horizontalSpacing: model.cellSpacing, verticalSpacing: model.cellSpacing) {
                ForEach(0..<7) { row in
                    GridRow {
                        ForEach(0..<model.columnCount, id: \.self) { column in
                            let index = row + column * 7
                            
                            let date = Calendar.current.date(
                                byAdding: .day,
                                value: index - model.paddingCellCount,
                                to: model.date
                            )!
                            
                            let state: Mark.State =
                            if !model.validIndexRange.contains(index) {
                                .placeholder
                            } else if records.contains(where: { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }) {
                                .checked
                            } else if date.isToday {
                                .today
                            } else {
                                .unchecked
                            }
                            
                            Mark(state: state)
                        }
                    }
                    .frame(width: cellSize)
                }
            }
        }
        .contentShape(.rect)
        .onTapGesture { ModalManager.shared.present(.habitCalendarSheet(model.habit, model.date)) }
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
        MonthGridViewModel(date: date, habit: habit)
    }
    
    VStack(spacing: 32.0) {
        MonthGrid(cellSize: 22.0, model: model)
        Stepper(stepperText, value: $offset)
            .frame(width: 240.0)
    }
}
