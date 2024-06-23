//
//  EmployeesListView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct EmployeesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var modelType: ModelShift?
    @Query(sort: \Employees.name) private var employees: [Employees]
    
    var body: some View {
        NavigationStack{
            Group{
                if employees.isEmpty {
                    ContentUnavailableView("Erstelle deinen ersten Mitarbeiter, klicke hierzu auf das Plus \(Image(systemName: "plus.circle.fill")) oben rechts.", systemImage: "")
                } else {
                    List(employees) { employee in
                        HStack{
                            Text(employee.name.capitalized)
                            Spacer()
                                Text("aktiv")
                                    .foregroundColor(.green)
                        }
                        
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive){
                                modelContext.delete(employee)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button {
                                modelType = .updateNewEmployee(employee)
                            } label: {
                                Label("Bearbeiten", systemImage: "pencil")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                Divider()
                    .navigationTitle("Mitarbeiterliste")
                    .toolbar {
                        Button {
                            modelType = .newEmployee
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .sheet(item: $modelType) { sheet in
                            sheet
                                .presentationDetents([.medium])
                        }
                    }
            }
        }
    }
}

