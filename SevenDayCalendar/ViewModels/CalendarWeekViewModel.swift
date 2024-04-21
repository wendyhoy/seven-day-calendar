//
//  CalendarWeekViewModel.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import Foundation

class CalendarWeekViewModel: ObservableObject {
    let numDays: UInt = 7
    @Published var days: [CalendarDayModel] = []

    init(date: Date) {
        days = getDays(today: date)
    }
    
    func loadBackgroundImages(currentWeek: [CalendarDayModel]) async {
        let currentWeekWithImages = await updateBackgroundImages(currentWeek: currentWeek)
        
        Task { @MainActor in
            days = currentWeekWithImages
        }
    }
    
    func refresh(date: Date) async {
        let currentWeek = getDays(today: date)
        let currentWeekWithImages = await updateBackgroundImages(currentWeek: currentWeek)

        Task { @MainActor in
            days = currentWeekWithImages
        }
    }

    private func getDays(today: Date) -> [CalendarDayModel] {
        let weekday = Calendar.current.component(.weekday, from: today)
        var currentWeek: [CalendarDayModel] = []

        // Creates one day for every day of this week
        for index in 1...Int(numDays) {
            let day = Calendar.current.date(byAdding: .day, value: index-weekday, to: today)
            var formatted = day!.formatted(
                Date.FormatStyle()
                    .weekday(.abbreviated)
                    .month(.abbreviated)
                    .day(.twoDigits)
            )
            
            if day == today {
                formatted = "Today: \(formatted)"
            }
            
            let calendarDay = CalendarDayModel(date: formatted)

            currentWeek.append(calendarDay)
        }

        return currentWeek
    }
    
    private func updateBackgroundImages(currentWeek: [CalendarDayModel]) async -> [CalendarDayModel] {
        var currentWeekWithImages = currentWeek
        
        do {
            let images = try await CuteAnimalsApi.shared.getImageUrls(numImages: numDays)

            currentWeekWithImages = currentWeek.enumerated().map { (index, day) in
                return CalendarDayModel(date: day.date, backgroundImageUrl: images[index])
            }
        } catch {
            print("Error: \(error).")
        }

        return currentWeekWithImages
    }
}
