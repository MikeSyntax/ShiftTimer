//
//  StaffFormModel.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

@Observable
class StaffFormModel {
    var date: Date = Date.now
    var comment: String = ""
    var shift: Shift?
    var staff: Staff?
    var updating: Bool { staff != nil }
    
    init(shift: Shift) {
        self.shift = shift
    }
    
    init(staff: Staff) {
        self.staff = staff
        self.shift = shift
        self.date = date
        self.comment = comment
        
    }
    
    var disabled: Bool {
        comment.isEmpty
    }
}
