//
//  EmployeesFormModel.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 23.06.24.
//

import SwiftUI

@Observable
class EmployeesFormModel {
    var name: String = ""
    var isActive: Bool = true
    var id: String = UUID().uuidString
    
    var employees: Employees?
    
    var updating: Bool { employees != nil }
    
    init() {}
    
    init(employees: Employees) {
        self.name = name
        self.id = id
        self.isActive = isActive
        
    }
    
    var disabled: Bool {
        name.isEmpty
    }
}
