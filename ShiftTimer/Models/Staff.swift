//
//  Staff.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

@Model
class Staff {
    var date: Date
    var shift: Shift?
    var comment: String
    
    init(date: Date, comment: String = ""){
        
        self.date = date
        self.comment = comment
    }
}
