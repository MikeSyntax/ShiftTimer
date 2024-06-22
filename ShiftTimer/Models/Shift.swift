//
//  Shift.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

@Model class Shift {
    var name: String
    @Relationship(deleteRule: .cascade)
    var icon: ShiftSymbol.RawValue
    var staff: [Staff] = []
    var startTime: Date
    var endTime: Date
    var hexColor: String
    
    init(name: String, icon: ShiftSymbol = .calendar, startTime: Date, endTime: Date, hexColor: String = "FF0000") {
        
        self.name = name
        self.icon = icon.rawValue
        self.startTime = startTime
        self.endTime = endTime
        self.hexColor = hexColor
    }
}
