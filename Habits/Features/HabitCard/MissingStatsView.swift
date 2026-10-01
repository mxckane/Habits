//
//  MissingStatsView.swift
//  Habits
//
//  Created by Andrey on 30/09/2026.
//

import SwiftUI

struct MissingStatsView: View {
    var body: some View {
        VStack(spacing: 8.0) {
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 30.0))
                .frame(width: 38.0, height: 38.0)
            Text("An error occurred while attempting to load your statistics")
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 16.0))
                .multilineTextAlignment(.center)
            Text("Try closing and restarting the app")
                .foregroundStyle(.labelSecondary)
                .font(.system(size: 14.0))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 38.0)
        .padding(.vertical, 16.0)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .strokeBorder(
                    .accentSecondary,
                    style: .init(
                        lineWidth: 1.5,
                        lineCap: .round,
                        lineJoin: .round,
                        dash: [12.0]
                    ),
                    antialiased: true
                )
        }
    }
}

#Preview {
    MissingStatsView()
        .padding(.horizontal)
}
