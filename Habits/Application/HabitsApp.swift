//
//  HabitsApp.swift
//  Habits
//
//  Created by Andrey on 27/04/2026.
//

import SwiftData
import SwiftUI

@main struct HabitsApp: App {
    init() {
        AppService.setupNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            Homepage()
        }
        .modelContainer(DataManager.shared.container)
    }
}
