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
        days = getDays(date: date)
    }

    func loadBackgroundImages(calendarDays: [CalendarDayModel]) async {
        let daysWithImages = await getBackgroundImages(calendarDays: calendarDays)

        let task = Task { @MainActor in
            days = daysWithImages
        }
        
        await task.value
    }

    func refresh(date: Date) async {
        let refreshDays = getDays(date: date)
        let daysWithImages = await getBackgroundImages(calendarDays: refreshDays)

        let task = Task { @MainActor in
            days = daysWithImages
        }
        
        await task.value
    }

    private func getDays(date: Date) -> [CalendarDayModel] {
        let weekday = Calendar.current.component(.weekday, from: date)
        var calendarDays: [CalendarDayModel] = []

        // Creates one day for every day of this week
        for index in 1...Int(numDays) {
            let day = Calendar.current.date(byAdding: .day, value: index-weekday, to: date)!
            var formatted = day.formatted(
                Date.FormatStyle()
                    .weekday(.abbreviated)
                    .month(.abbreviated)
                    .day(.twoDigits)
            )

            if Calendar.current.isDateInToday(day) {
                formatted = "Today: \(formatted)"
            }

            let calendarDay = CalendarDayModel(dateStr: formatted)

            calendarDays.append(calendarDay)
        }

        return calendarDays
    }

    private func getBackgroundImages(calendarDays: [CalendarDayModel]) async -> [CalendarDayModel] {
        var daysWithImages = calendarDays

        do {
            let images = try await CuteAnimalsApi.shared.getImageUrls(numImages: numDays)

            daysWithImages = calendarDays.enumerated().map { (index, day) in
                return CalendarDayModel(dateStr: day.dateStr, backgroundImageUrl: images[index])
            }
        } catch {
            print("Error: \(error).")
        }

        return daysWithImages
    }
}
