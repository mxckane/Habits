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
                    VStack(spacing: 16) {
                        ForEach(habits) { habit in
                            HabitCard(habit)
                                .padding([.leading, .trailing], 16)
                        }
                    }
                    .padding([.top, .bottom], 16)
                }
            }
            .navigationTitle("Habits")
            .scrollIndicators(.hidden)
            .background(Color.background)
            .toolbar(content: newHabitButton)
            .ignoresSafeArea(.all, edges: .bottom)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .modalPresenter()
        .ignoresSafeArea(.container)
    }

    @ViewBuilder func newHabitButton() -> some View {
        Button {
            ModalManager.shared.present(.newHabitSheet)
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.isLiquidGlassAvailable ? .complementary : .accent)
                .glassEffect(isClear: false, isInteractive: false, tint: .accentGlass)
        }
    }
}

#Preview {
    Homepage()
        .modelContainer(DataManager.shared.container)
}
