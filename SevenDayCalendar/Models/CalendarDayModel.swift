//
//  CalendarDayModel.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-20.
//

import Foundation

/// Represents a day in the calendar.
struct CalendarDayModel: Identifiable {
    let id = UUID()
    let date: Date
    var dateStr = ""
    var backgroundImageUrl: URL?

    /// Creates a day in the calendar and formats the given date.
    /// - Parameters:
    ///   - date: The reference date.
    ///   - backgroundImageUrl: URL for the background image.
    init(date: Date, backgroundImageUrl: URL? = nil) {
        self.date = date
        self.dateStr = formatDate(date: date)
        self.backgroundImageUrl = backgroundImageUrl
    }
    
    /// Formats the given date into a string for the view.
    /// - Parameter date: The date to format.
    /// - Returns: The formatted string of the date, ex. Tue, Apr 23.
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
