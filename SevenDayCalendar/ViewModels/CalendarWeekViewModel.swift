//
//  CalendarWeekViewModel.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import Foundation

/// Represents the calendar week.
class CalendarWeekViewModel: ObservableObject {
    let numDays: UInt = 7
    @Published var days: [CalendarDayModel] = []
    
    /// Generates the days of the week given a date.
    /// - Parameter date: The reference date.
    init(date: Date) {
        days = getDays(date: date)
    }
    
    /// Loads the background image URL into each day of the given week.
    /// - Parameter calendarDays: An array of calendar days to update.
    @MainActor
    func loadBackgroundImages(calendarDays: [CalendarDayModel]) async {
        let daysWithImages = await getBackgroundImages(calendarDays: calendarDays)

        days = daysWithImages
    }

    /// Updates the days of the week given a date and loads new background image URLs.
    /// - Parameter date: The reference date.
    @MainActor
    func refresh(date: Date) async {
        let refreshDays = getDays(date: date)
        let daysWithImages = await getBackgroundImages(calendarDays: refreshDays)

        days = daysWithImages
    }
    
    /// Returns the days of the week given a date.
    /// - Parameter date: The reference date.
    /// - Returns: The days of the week for the given date.
    private func getDays(date: Date) -> [CalendarDayModel] {
        let weekday = Calendar.current.component(.weekday, from: date)
        var calendarDays: [CalendarDayModel] = []

        // Creates one day for every day of this week
        for index in 1...Int(numDays) {
            let day = Calendar.current.date(byAdding: .day, value: index-weekday, to: date)!
            let calendarDay = CalendarDayModel(date: day)

            calendarDays.append(calendarDay)
        }

        return calendarDays
    }
    
    /// Updates the background image URLs of the given calendar days.
    /// - Parameter calendarDays: An array of calendar days to update.
    /// - Returns: An array of calendar days with updated background image URLs.
    private func getBackgroundImages(calendarDays: [CalendarDayModel]) async -> [CalendarDayModel] {
        var daysWithImages = calendarDays

        do {
            let images = try await CuteAnimalsApi.shared.getImageUrls(numImages: numDays)

            daysWithImages = calendarDays.enumerated().map { (index, day) in
                return CalendarDayModel(date: day.date, backgroundImageUrl: images[index])
            }
        } catch {
            print("Error: \(error).")
        }

        return daysWithImages
    }
}
