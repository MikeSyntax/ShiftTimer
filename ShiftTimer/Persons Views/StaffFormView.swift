//
//  StaffFormView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

struct StaffFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var model: StaffFormModel
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Form{
                    Section(header: Text("Wähle den Tag für die Schicht")) {
                        DatePicker("Wähle den Tag", selection: $model.date, displayedComponents: .date)
                    }
                    Section(header: Text("Personal")) {
                        TextField("Wählen Sie einen Mitarbeiter", text: $model.comment, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: .infinity)
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
                    .padding(.top)
                    Spacer()
                }
                .padding()
                .navigationTitle(model.updating ? "Bearbeiten" : "Erstellen")
                .navigationBarTitleDisplayMode(.inline)
            }
        
    }
}

//#Preview {
//    StaffFormView(model: StaffFormModel(shift: Shift(name: "", startTime: Date(), endTime: Date())))
//}
