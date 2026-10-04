//
//  MonthGrid.swift
//  Habits
//
//  Created by Andrey on 28/08/2026.
//

import SwiftData
import SwiftUI

struct MonthGrid: View {
    @Query private var records: [Record]

    static let cellSpacing: CGFloat = 2.0

    private let model: MonthGridViewModel
    private let cellSize: CGFloat

    init(cellSize: CGFloat, model: MonthGridViewModel) {
        let habitID = model.habit.id
        let timeInterval = model.date.interval(of: .month)

        let predicate = #Predicate<Record> {
            $0.habit?.id == habitID &&
            $0.timestamp >= timeInterval.start &&
            $0.timestamp < timeInterval.end
        }

        self._records = Query(filter: predicate, sort: \.timestamp)
        self.model = model
        self.cellSize = cellSize
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(model.monthName)
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 13.0))
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(height: 16.0)
            Grid(horizontalSpacing: Self.cellSpacing, verticalSpacing: Self.cellSpacing) {
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
                            } else if records.contains(where: { record in
                                Calendar.current.isDate(record.timestamp, inSameDayAs: date)
                            }) {
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
        .onTapGesture {
            ModalManager.shared.present(.habitCalendarSheet(model.habit, model.date))
        }
    }
}

#Preview {
    @Previewable @State var offset = 0

    var date: Date {
        Calendar.current.date(byAdding: .month, value: offset, to: .now)!
    }

    var stepperText: String {
        "\(date.formatted(.dateTime.month(.wide))) \(date.formatted(.dateTime.year()))"
    }

    var model: MonthGridViewModel {
        MonthGridViewModel(date: date, habit: .sample)
    }

    VStack(spacing: 32.0) {
        MonthGrid(cellSize: 22.0, model: model)
        Stepper(stepperText, value: $offset)
            .frame(width: 240.0)
    }
}
