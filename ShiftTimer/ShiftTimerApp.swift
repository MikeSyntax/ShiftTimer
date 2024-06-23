//
//  ShiftTimerApp.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

@main
struct ShiftTimerApp: App {
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .modelContainer(for: Shift.self)
        }
    }
}
