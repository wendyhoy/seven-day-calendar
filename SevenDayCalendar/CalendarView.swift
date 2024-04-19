//
//  ContentView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var calendarWeek: CalendarWeek
    
    var body: some View {
        VStack {
            Text("Cute Animal Seven-Day Calendar")
                .font(.headline)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(calendarWeek.days) {
                        calendarDay in Text(calendarDay.date)
                            .font(.largeTitle)
                            .padding(80)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().fill(.red))
                            .border(.black)
                    }
                }
            }
        }
        .padding(10)
    }
}
