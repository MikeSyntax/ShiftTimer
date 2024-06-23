//
//  StaffListView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct StaffListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var modelType: ModelShift?
    var shift: Shift
    
    var body: some View {
        @Bindable var shift = shift
        Group{
            if shift.staff.isEmpty {
                ContentUnavailableView("Teile deine Mitarbeiter für die \(shift.name) ein und klicke rechts oben das \(Image(systemName: "plus.circle.fill"))", systemImage: "\(shift.icon)")
            } else {
                List(shift.staff.sorted(
                    using: KeyPathComparator(\Staff.date, order: .reverse)
                )) { staff in
                    HStack{
                        Image(systemName: shift.icon)
                            .foregroundStyle(Color(hex: shift.hexColor)!)
                        VStack(alignment: .leading){
                            Text(formattedTime(time: staff.date))
                            Text(staff.comment)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive){
                            if let index = shift.staff.firstIndex(where: {$0.id == staff.id }) {
                                shift.staff.remove(at: index)
                            }
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            modelType = .updateStaff(staff)
                        }label: {
                            Label("Bearbeiten", systemImage: "pencil")
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        Divider()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(Image(systemName: shift.icon)) \(shift.name)")
                    .font(.title)
                    .foregroundStyle(Color(hex: shift.hexColor)!)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    modelType = .newStaff(shift)
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
    
    func formattedTime(time: Date) -> String {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: time)
        let day = components.day ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        return String(format: "%d.%02d.%d", day, month, year)
    }
}
