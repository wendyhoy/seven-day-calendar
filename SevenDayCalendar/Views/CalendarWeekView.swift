//
//  ContentView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

/// Displays the days of the week and can trigger updating the days and background images.
struct CalendarWeekView: View {
    @EnvironmentObject var currentWeek: CalendarWeekViewModel

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(currentWeek.days) {
                        day in CalendarDayView(calendarDay: day)
                    }
                }
            }
        }
        .navigationTitle("TGI Furiday")
        .task {
            await currentWeek.loadBackgroundImages(calendarDays: currentWeek.days)
        }
        .refreshable {
            await currentWeek.refresh(date: Date.now)
        }
    }
}
