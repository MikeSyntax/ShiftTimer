//
//  ModelShift.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

enum ModelShift: View, Identifiable, Equatable {
    case newShift
    case updateNewShift(Shift)
    case newStaff(Shift)
    case updateStaff(Staff)
    
    var id: String {
        switch self {
        case .newShift:
            "newShift"
        case .updateNewShift:
            "updateShift"
        case .newStaff:
            "newStaff"
        case .updateStaff:
            "updateStaff"
        }
    }
    
    var body: some View {
        switch self {
        case .newShift:
            ShiftFormView(model: ShiftFormModel())
        case .updateNewShift(let shift):
            ShiftFormView(model: ShiftFormModel(shift: shift))
        case .newStaff(let shift):
            StaffFormView(model: StaffFormModel(shift: shift))
        case .updateStaff(let staff):
            StaffFormView(model: StaffFormModel(staff: staff))
            
        }
    }
}

