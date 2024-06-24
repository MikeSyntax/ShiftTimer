//
//  EmployeesFormView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 23.06.24.
//

import SwiftUI
import SwiftData

struct EmployeesFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var model: EmployeesFormModel
    
    var body: some View {
        ZStack{
            Color(UIColor.systemBackground).ignoresSafeArea(.all)
            NavigationStack{
                VStack(spacing: 20){
                    Form{
                        Section(header: Text("Mitarbeitername")){
                            TextField("Wähle einen Namen", text: $model.name)
                                .textFieldStyle(.roundedBorder)
                        }
                        .keyboardType(.default)
                        .submitLabel(.done)
                        Section(header: Text("Mitarbeiter aktiv")){
                            Toggle(model.isActive ? "aktiv" : "inaktiv", isOn: $model.isActive)
                        }
                    }
                    
                    Button(model.updating ? "Bearbeiten" : "Erstellen"){
                        if model.updating {
                            model.employees?.name = model.name
                            model.employees?.isActive = model.isActive
                        } else {
                            let newEmployee = Employees(name: model.name, id: model.id, isActive: model.isActive)
                            modelContext.insert(newEmployee)
                        }
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                    .disabled(model.disabled)
                    .padding(.top)
                    Spacer()
                }
                .padding(40)
                .navigationTitle(model.updating ? "Mitarbeiter bearbeiten" : "Neuer Mitarbeiter")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
