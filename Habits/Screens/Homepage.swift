//
//  Homepage.swift
//  Habits
//
//  Created by Andrey on 27/04/2026.
//

import SwiftData
import SwiftUI

struct Homepage: View {
    @Query(sort: \Habit.timestamp, order: .reverse) private var habits: [Habit]

    var body: some View {
        NavigationStack {
            ScrollView {
                if !habits.isEmpty {
                    VStack(spacing: 16.0) {
                        ForEach(habits) { habit in
                            HabitCard(habit)
                                .padding(.horizontal, 16.0)
                        }
                    }
                    .padding(.vertical, 16.0)
                }
            }

            .navigationTitle("Habits")
            .scrollIndicators(.hidden)
            .background(.backgroundPrimary)
            .toolbar(content: newHabitButton)
            .ignoresSafeArea(.all, edges: .bottom)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .modalPresenter()
        .ignoresSafeArea(.container)
    }

    @ViewBuilder func newHabitButton() -> some View {
        if #available(iOS 26.0, *) {
            Button {
                ModalManager.shared.present(.newHabitSheet)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17.0))
                    .fontWeight(.medium)
                    .foregroundStyle(.labelPrimary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentPrimary)
        } else {
            Button {
                ModalManager.shared.present(.newHabitSheet)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 15.0))
                    .fontWeight(.medium)
                    .foregroundStyle(.labelPrimary)
                    .frame(width: 32.0, height: 32.0)
                    .background(.accentPrimary, in: .circle)
            }
        }
    }
}

#Preview {
    Homepage()
        .modelContainer(DataManager.shared.container)
}
