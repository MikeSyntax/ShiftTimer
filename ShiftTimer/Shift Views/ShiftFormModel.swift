//
//  ShiftFormModel.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

@Observable
class ShiftFormModel {
    var name: String = ""
    var icon: ShiftSymbol = .calendar
    var startTime = Date()
    var endTime = Date()
    var hexColor: Color = .red
    
    var shift: Shift?
    
    var updating: Bool { shift != nil }
    
    init () {}
    
    init(shift: Shift){
        self.shift = shift
        self.name = name
        self.icon = icon
        self.startTime = startTime
        self.endTime = endTime
        self.hexColor = hexColor
    }
    
    var disabled: Bool {
        name.isEmpty
    }
}
