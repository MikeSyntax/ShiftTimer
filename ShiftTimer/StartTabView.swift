//
//  StartTabView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

struct StartTabView: View {
    var body: some View {
        TabView{
            ShiftListView()
            .tabItem {
                Label("Schichtplan", systemImage: "square.3.layers.3d.down.forward")
            }
//            PersonsListView(shift: <#Shift#>)
//                .tabItem {
//                    Label("Personal", systemImage: "person.3")
//                }
            CalendarView()
                .tabItem {
                    Label("Kalender", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    StartTabView()
}
