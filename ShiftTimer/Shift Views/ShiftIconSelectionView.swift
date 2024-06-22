//
//  ShiftIconSelectionView.swift
//  ShiftTimer
//
//  Created by Mike Reichenbach on 22.06.24.
//

import SwiftUI

struct ShiftIconSelectionView: View {
    @Binding var selectingIcon: Bool
    @Binding var selectedIcon: ShiftSymbol
    let columns = [GridItem(.adaptive(minimum: 40))]
    var body: some View {
        ZStack{
            Color.white.opacity(0.1)
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .frame(width: 300, height: 420)
                        .overlay(
                            VStack{
                                ScrollView(showsIndicators: true){
                                    LazyVGrid(columns: columns, spacing: 28){
                                        ForEach(ShiftSymbol.allCases, id: \.self){ symbol in
                                            Button {
                                                selectedIcon = symbol
                                                withAnimation {
                                                    selectingIcon = false
                                                }
                                            } label: {
                                                Image(systemName: symbol.rawValue)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 30)
                                                    .tint(selectedIcon == symbol ? .red : .blue )
                                                    .scaleEffect(selectedIcon == symbol ? 1.5 : 1)
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                .padding()
                                Spacer()
                            })
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var selectedIcon: ShiftSymbol = .calendar
        var body: some View {
            ShiftIconSelectionView(selectingIcon: .constant(true), selectedIcon: $selectedIcon)
        }
    }
    return Preview()
}
