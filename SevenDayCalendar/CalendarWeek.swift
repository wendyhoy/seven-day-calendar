//
//  CalendarWeek.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import Foundation

struct CalendarDay: Identifiable {
    let id = UUID()
    let date: String
    var backgroundImageUrl: URL?
}

class CalendarWeek: ObservableObject {
    let numDays: UInt = 7
    @Published var days: [CalendarDay] = []
    
    init(today: Date) {
        let weekday = Calendar.current.component(.weekday, from: today)
        var currentWeek: [CalendarDay] = []
        
        // Creates one day for every day of this week
        for index in 1...Int(numDays) {
            let day = Calendar.current.date(byAdding: .day, value: index-weekday, to: today)
            let formatted = day!.formatted(date: .complete, time: .omitted)
            let calendarDay = CalendarDay(date: formatted)
            
            currentWeek.append(calendarDay)
        }
        
        self.days = currentWeek
    }
    
    func loadBackgroundImages() async {
        do {
            let backgroundImageApi = CuteAnimalsApi()
            let images = try await backgroundImageApi.getImageUrls(numImages: numDays)
            
            Task { @MainActor in
                self.days = self.days.enumerated().map { (index, day) in
                    return CalendarDay(date: day.date, backgroundImageUrl: images[index])
                }
                print(self.days)
            }
        } catch {
            print("Error: \(error).")
        }
    }
}
