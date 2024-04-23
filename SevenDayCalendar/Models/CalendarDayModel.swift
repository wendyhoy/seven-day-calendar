//
//  CalendarDayModel.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-20.
//

import Foundation

struct CalendarDayModel: Identifiable {
    let id = UUID()
    let date: Date
    var dateStr = ""
    var backgroundImageUrl: URL?

    init(date: Date, backgroundImageUrl: URL? = nil) {
        self.date = date
        self.dateStr = formatDate(date: date)
        self.backgroundImageUrl = backgroundImageUrl
    }

    private func formatDate(date: Date) -> String {
        var formatted = date.formatted(
            Date.FormatStyle()
                .weekday(.abbreviated)
                .month(.abbreviated)
                .day(.twoDigits)
        )

        if Calendar.current.isDateInToday(date) {
            formatted = "Today: \(formatted)"
        }

        return formatted
    }
}
