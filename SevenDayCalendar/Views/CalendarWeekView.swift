//
//  ContentView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

struct CalendarWeekView: View {
    @EnvironmentObject var calendarWeek: CalendarWeekViewModel

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(calendarWeek.days) {
                        day in CalendarDayView(calendarDay: day)
                    }
                }
            }
        }
        .navigationTitle("TGI Furiday")
        .task {
            await calendarWeek.loadBackgroundImages(currentWeek: calendarWeek.days)
        }
        .refreshable {
            await calendarWeek.refresh(date: Date.now)
        }
    }
}
