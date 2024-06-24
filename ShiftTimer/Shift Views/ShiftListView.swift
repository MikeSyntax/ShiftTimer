//
//  ShiftListView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct ShiftListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var modelType: ModelShift?
    @Query(sort: \Shift.name) private var shifts: [Shift]
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            Group{
                if shifts.isEmpty {
                    ContentUnavailableView("Erstelle deine erste Schicht, klicke hierzu auf das Plus \(Image(systemName: "plus.circle.fill")) oben rechts.", image: "" )
                } else {
                    List(shifts) { shift in
                        NavigationLink(value: shift){
                            HStack{
                                Image(systemName: shift.icon)
                                    .foregroundStyle(Color(hex: shift.hexColor)!)
                                    .font(.system(size: 25))
                                    .frame(width: 30)
                                VStack(alignment: .leading){
                                    Text(shift.name.capitalized)
                                    Text("\(formattedTime(time: shift.startTime)) - \(formattedTime(time: shift.endTime)) Uhr")
                                }
                                Spacer()
                                VStack{
                                    Text("  ")
                                }
                                VStack(alignment: .trailing){
                                    //Pluralwert wird von Swift UI automatisch ausgewählt
                                    Text("^[\(shift.staff.count) Mitarbeiter eingeteilt](inflect: true)")
                                }
                            }
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        }
                        .swipeActions(edge: .trailing){
                            Button(role: .destructive){
                                modelContext.delete(shift)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button {
                                modelType = .updateNewShift(shift)
                            } label: {
                                Label("Bearbeiten", systemImage: "pencil")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
             
            }
            Divider()
            .navigationTitle("Schichtplan")
            .toolbar {
                Button {
                    modelType = .newShift
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(item: $modelType) { sheet in
                    sheet
                        .presentationDetents([.large])
                }
            }
            .navigationDestination(for: Shift.self) { shift in
                StaffListView(shift: shift)
            }
        }
    }
    
    func formattedTime(time: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return String(format: "%02d:%02d", hour, minute)
    }
}


