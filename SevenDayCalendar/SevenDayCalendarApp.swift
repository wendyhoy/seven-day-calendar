//
//  SevenDayCalendarApp.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

@main
struct SevenDayCalendarApp: App {
    @StateObject private var currentWeek = CalendarWeek()
    
    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environmentObject(currentWeek)
        }
    }
}
