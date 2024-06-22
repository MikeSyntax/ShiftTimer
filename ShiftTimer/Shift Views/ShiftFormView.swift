//
//  ShiftFormView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct ShiftFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var model: ShiftFormModel
    @State private var selectingIcon: Bool = false
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        ZStack{
            Color(UIColor.systemBackground).ignoresSafeArea(.all)
            NavigationStack{
                VStack(spacing: 20){
                        Form {
                            Section(header: Text("Wähle einen Schichtnamen")){
                                TextField("Schichtname", text: $model.name)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Section(header: Text("Wähle ein passendes Icon")){
                                Button {
                                    selectingIcon.toggle()
                                } label: {
                                    Image(systemName: model.icon.rawValue)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            
                            Section(header: Text("Startzeit")){
                                DatePicker("Wähle eine Startzeit", selection: $startTime, displayedComponents: .hourAndMinute)
                            }
                            Section(header: Text("Endzeit")){
                                DatePicker("Wähle eine Endzeit", selection: $endTime, displayedComponents: .hourAndMinute)
                            }
                            Section(header: Text("Icon Farbe")){
                                ColorPicker("Wähle eine IconFarbe", selection: $model.hexColor, supportsOpacity: false)
                            }
                        }
                    .padding(.top)
                    Button(model.updating ? "Bearbeiten" : "Erstellen"){
                        if model.updating {
                            model.shift?.name = model.name
                            model.shift?.icon = model.icon.rawValue
                            model.shift?.startTime = model.startTime
                            model.shift?.endTime = model.endTime
                            model.shift?.hexColor = model.hexColor.toHex()!
                        } else {
                            let newShift = Shift(name: model.name, icon: model.icon, startTime: startTime, endTime: endTime, hexColor: model.hexColor.toHex()!)
                            modelContext.insert(newShift)
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
                .navigationTitle(model.updating ? "Schicht bearbeiten" : "Neue Schicht")
                .navigationBarTitleDisplayMode(.inline)
            }
            if selectingIcon {
                ShiftIconSelectionView(selectingIcon: $selectingIcon, selectedIcon: $model.icon)
            }
        }
    }
}

#Preview {
    ShiftFormView(model: ShiftFormModel())
}
