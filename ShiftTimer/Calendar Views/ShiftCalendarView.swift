//
//  ShiftCalendarView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct ShiftCalendarView: View {
    @State private var monthDate = Date.now
    @State private var years: [Int] = []
    @State private var selectedMonth = Date.now.monthInt
    @State private var selectedYear = Date.now.yearInt
    @Query private var staffs: [Staff]
    @Query(sort: \Shift.name) private var shifts: [Shift]
    @State private var selectedShift: Shift?
    let months = Date.fullMonathNames
    
    var body: some View {
        NavigationStack{
            Divider()
            VStack{
                HStack{
                    Picker("", selection: $selectedShift){
                        Text("Alle Schichten").tag(nil as Shift?)
                        ForEach(shifts) { shift in
                            Text(shift.name).tag(shift as Shift?)
                        }
                    }
                    HStack{
                        Picker("", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text(String(year))
                            }
                        }
                    }
                    Picker("", selection: $selectedMonth) {
                        ForEach(months.indices, id: \.self) { index in
                            Text(months[index]).tag(index + 1)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                CalendarView(date: monthDate, selectedShift: selectedShift)
                Spacer()
                Divider()
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            .navigationTitle("Schicht Kalender")
        }
        .onAppear{
            years = Array(Set(staffs.map { $0.date.yearInt }.sorted()))
        }
        .onChange(of: selectedYear) {
            updateDate()
        }
        .onChange(of: selectedMonth) {
            updateDate()
        }
    }
    func updateDate(){
        monthDate = Calendar.current.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: 1))!
    }
}
