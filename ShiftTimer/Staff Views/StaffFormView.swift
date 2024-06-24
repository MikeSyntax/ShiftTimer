//
//  StaffFormView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct StaffFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var model: StaffFormModel
    @Query(sort: \Employees.name) private var employees: [Employees]
    
    var body: some View {
        ZStack{
            Color(UIColor.systemBackground).ignoresSafeArea(.all)
            NavigationStack{
                VStack(spacing: 20) {
                    Form{
                        Section(header: Text("Wähle den Tag für die Schicht")) {
                            DatePicker("Wähle den Tag", selection: $model.date, displayedComponents: .date)
                        }
                        Section(header: Text("Personal")) {
                            TextField("Wählen Sie einen Mitarbeiter", text: $model.comment)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: .infinity)
                        }
                        .keyboardType(.default)
                        .submitLabel(.done)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(employees, id: \.self){ employee in
                                            Button(action: {
                                                if employee.isActive {
                                                    model.comment = employee.name
                                                }
                                            }) {
                                                Text(employee.name.capitalized)
                                                    .foregroundColor(employee.isActive ? .white : .red )
                                                    .strikethrough(!employee.isActive)
                                            }
                                            .buttonStyle(.borderedProminent)
                                            .padding(1)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Button(model.updating ? "Bearbeiten" : "Erstellen") {
                        if model.updating {
                            model.staff?.date = model.date
                            model.staff?.comment = model.comment
                        } else {
                            let newStaff = Staff(date: model.date, comment: model.comment)
                            model.shift?.staff.append(newStaff)
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .disabled(model.disabled)
                    .padding(.top)
                    Spacer()
                }
                .padding()
                .navigationTitle(model.updating ? "Einteilung Bearbeiten" : "Einteilung Erstellen")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

