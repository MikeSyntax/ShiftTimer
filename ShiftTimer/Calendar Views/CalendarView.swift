//
//  CalendarView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    let selectedShift: Shift?
    @Query private var staffs: [Staff]
    @State private var counts = [Int:Int]()
    
    init(date: Date, selectedShift: Shift?){
        self.date = date
        self.selectedShift = selectedShift
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: date.endOfMonth)!
        let predicate = #Predicate<Staff>{$0.date >= date.startOfMonth && $0.date <= endOfMonthAdjustment}
        _staffs = Query(filter: predicate, sort: \Staff.date)
    }
    
    var body: some View {
        let color = selectedShift == nil ? .blue : Color(hex: selectedShift!.hexColor)!
        
        VStack{
            HStack{
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self){ day in
                    NavigationLink(destination: destinationView(for: day)){
                        if day.monthInt != date.monthInt {
                            Text("")
                        } else {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(
                                            Date.now.startOfDay == day.startOfDay ?
                                                .red.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3) :
                                                color.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                                
                                        )
                                        
                                )
                                .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 2) // Schwarzer Rand mit einer Breite von 1
                                    )
                                .overlay(alignment: .bottomTrailing){
                                    if let count = counts[day.dayInt] {
                                        Image(systemName: count <= 50 ? "\(count).circle.fill" : "plus.circle.fill")
                                            .foregroundColor(.secondary)
                                            .imageScale(.medium)
                                            .background(
                                                Color(.systemBackground)
                                                    .clipShape(.circle)
                                            )
                                            .offset(x: 5, y: 5)
                                    }
                                }
                        }
                    }
                    
                }
            }
        }
//        .navigationDestination(for: Staff.self) { staff in
//            EmployeesListView()
//        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
            setupCount()
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
            setupCount()
        }
        .onChange(of: selectedShift) {
            setupCount()
        }
        
    }
    func setupCount(){
        var filteredStaff = staffs
        if let selectedShift {
            filteredStaff = staffs.filter { $0.shift == selectedShift }
        }
        let mappedItems = filteredStaff.map {($0.date.dayInt, 1)}
        counts = Dictionary(mappedItems, uniquingKeysWith: +)
    }
    private func destinationView(for date: Date) -> some View {
        return EmployeesListView()
    }
}


