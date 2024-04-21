//
//  ContentView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

struct CalendarWeekView: View {
    @EnvironmentObject var calendarWeek: CalendarWeek

    var body: some View {
        VStack {
            Text("Cute Animal Seven-Day Calendar")
                .font(.headline)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(calendarWeek.days) {
                        day in CalendarDayView(calendarDay: day)
                    }
                }
            }
        }
        .padding(10)
        .task {
            await calendarWeek.loadBackgroundImages()
        }
    }
}
