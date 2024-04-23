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

    @MainActor
    func loadBackgroundImages(calendarDays: [CalendarDayModel]) async {
        let daysWithImages = await getBackgroundImages(calendarDays: calendarDays)

        days = daysWithImages
    }

    @MainActor
    func refresh(date: Date) async {
        let refreshDays = getDays(date: date)
        let daysWithImages = await getBackgroundImages(calendarDays: refreshDays)

        days = daysWithImages
    }

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
