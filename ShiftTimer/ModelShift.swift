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
    
    var id: String {
        switch self {
        case .newShift:
            "newShift"
        case .updateNewShift:
            "updateShift"
        }
    }
    
    var body: some View {
        switch self {
        case .newShift:
            ShiftFormView(model: ShiftFormModel())
        case .updateNewShift(let shift):
            ShiftFormView(model: ShiftFormModel(shift: shift))
        }
    }
    
    
}

