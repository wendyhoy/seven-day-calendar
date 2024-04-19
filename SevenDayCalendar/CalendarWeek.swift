//
//  CalendarWeek.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import Foundation

class CalendarWeek: ObservableObject {
    
    @Published var days: [CalendarDay] = []
    
    init() {
        let today = Date.now
        let weekday = Calendar.current.component(.weekday, from: today)
        
        for index in 1...7 {
            let day = Calendar.current.date(byAdding: .day, value: index-weekday, to: today)
            let formatted = day!.formatted(date: .complete, time: .omitted)
            let calendarDay = CalendarDay(date: formatted, backgroundImageUrl: "")
            
            days.append(calendarDay)
        }
    }

}
