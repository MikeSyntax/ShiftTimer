//
//  Employees.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 23.06.24.
//

import SwiftUI
import SwiftData

@Model
class Employees {
    var name: String
    var id: String
    var isActive: Bool
    
    init(name: String = "", id: String = "", isActive: Bool = true) {
        
        self.name = name
        self.id = id
        self.isActive = isActive
        
    }
}
