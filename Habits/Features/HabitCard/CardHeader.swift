//
//  CardHeader.swift
//  Habits
//
//  Created by Andrey on 15/06/2026.
//

import SwiftUI

struct CardHeader: View {
    private let habit: Habit

    @State private var title: String
    @State private var emoji: String

    @State private var emojiScale = 1.0
    @State private var saturation: Double

    private var displayedEmoji: String { emoji.isEmpty ? .defaultHabitEmoji : emoji }

    init(habit: Habit) {
        self.habit = habit
        self.title = habit.title
        self.emoji = habit.emoji
        self.saturation = habit.emoji.isEmpty ? 0.0 : 1.0
    }

    var body: some View {
        HStack {
            HStack(spacing: 4.0) {
                Text(displayedEmoji)
                    .font(.system(size: 34.0))
                    .fontWeight(.medium)
                    .frame(width: 38.0, height: 38.0)
                    .saturation(saturation)
                    .contrast(habit.emoji.isEmpty ? 1.17 : 1.0)
                    .scaleEffect(emojiScale)
                Text(title)
                    .font(.system(size: 17.0))
                    .fontWeight(.semibold)
                    .contentTransition(.numericText())
            }
            .foregroundStyle(.accentPrimary)
            .onChange(of: [emoji: habit.emoji, title: habit.title]) { old, new in
                Task {
                    guard let oldEmoji = old[emoji],
                          let newEmoji = new[emoji],
                          let newTitle = new[title]
                    else {
                        return
                    }

                    if newTitle != title {
                        try? await Task.sleep(for: .seconds(0.5))
                        withAnimation { title = newTitle }
                    }

                    if newEmoji.isDefaultHabitEmoji && oldEmoji.isEmpty ||
                        oldEmoji.isDefaultHabitEmoji && newEmoji.isEmpty {
                        try? await Task.sleep(for: .seconds(0.75))
                        withAnimation(.smooth(duration: 0.8)) { saturation = newEmoji.isEmpty ? 0.0 : 1.0 }
                    } else {
                        if newEmoji != emoji {
                            try? await Task.sleep(for: .seconds(0.55))

                            withAnimation(.spring(.bouncy(duration: 0.3))) { emojiScale = 0.2 }
                            try? await Task.sleep(for: .seconds(0.15))

                            withAnimation(.spring(.bouncy(duration: 0.3))) { emojiScale = 1.0 }
                            saturation = newEmoji.isEmpty ? 0.0 : 1.0
                            emoji = newEmoji
                        }
                    }
                }
            }
            .onTapGesture {
                ModalManager.shared.present(.habitInfoSheet(habit))
            }

            Spacer()

            HStack(spacing: 8.0) {
                SwapButton(habit: habit) // TODO: Remove
                StreakButton(habit: habit)
            }
        }
    }
}

#Preview {
    CardHeader(habit: .sample)
        .padding(.horizontal, 16.0)
}
