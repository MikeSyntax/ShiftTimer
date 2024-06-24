//
//  StartTabView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

struct StartTabView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView{
            ShiftCalendarView()
                .tabItem {
                    Label("Kalender", systemImage: "calendar")
                }.tag(0)
            
            ShiftListView()
                .tabItem {
                    Label("Schichtplan", systemImage: "square.3.layers.3d.down.forward")
                }.tag(1)
            
            EmployeesListView()
                .tabItem {
                    Label("Mitarbeiter", systemImage: "person.3")
                }.tag(2)
        }
        .onAppear {
            self.selectedTab = 0
        }
    }
}

#Preview {
    StartTabView()
}
