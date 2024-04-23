//
//  SevenDayCalendarTests.swift
//  SevenDayCalendarTests
//
//  Created by Wendy Hoy on 2024-04-18.
//

import XCTest
@testable import SevenDayCalendar

/// Unit tests for the seven day calendar app.
final class SevenDayCalendarTests: XCTestCase {

    /// Tests that the CalendarWeekViewModel generates the right days of the week given a date.
    func testCalendarWeekViewModel_init() throws {
        var components = DateComponents()
        components.year = 2024
        components.month = 4
        components.day = 17

        let input = Calendar.current.date(from: components)!
        let expected: [String] = [
            "Sun, Apr 14",
            "Mon, Apr 15",
            "Tue, Apr 16",
            "Wed, Apr 17",
            "Thu, Apr 18",
            "Fri, Apr 19",
            "Sat, Apr 20"
        ]

        let actual = CalendarWeekViewModel(date: input).days

        for (index, day) in actual.enumerated() {
            XCTAssertEqual(day.dateStr, expected[index], "A day of the week is incorrect. Actual: \(day.dateStr) Expected: \(expected[index])")
        }
    }

    /// Tests that the CalendarWeekViewModel updates the background image URLs from the API.
    func testCalendarWeekViewModel_loadBackgroundImages() async throws {
        let week = CalendarWeekViewModel(date: Date.now)
        let input = week.days

        await week.loadBackgroundImages(calendarDays: input)

        for day in week.days {
            XCTAssertNotNil(day.backgroundImageUrl, "backgroundImageUrl for \(day.dateStr) should not be nil.")
        }
    }

    /// Tests that on refresh, the days are updated based on today and there are new background images.
    func testCalendarWeekViewModel_refresh() async throws {
        var components = DateComponents()
        components.year = 2024
        components.month = 4
        components.day = 17

        let date = Calendar.current.date(from: components)!
        let week = CalendarWeekViewModel(date: date)

        await week.loadBackgroundImages(calendarDays: week.days)

        let before = week.days

        await week.refresh(date: Date.now)

        let after = week.days
        var hasToday = false;

        for (index, day) in after.enumerated() {
            hasToday = hasToday || day.dateStr.hasPrefix("Today")
            XCTAssertNotEqual(day.dateStr, before[index].dateStr, "A date didn't refresh. After: \(day.dateStr) Before: \(before[index].dateStr)")
            XCTAssertNotEqual(day.backgroundImageUrl, before[index].backgroundImageUrl, "A backgroundImageUrl didn't refresh. After: \(day.backgroundImageUrl!) Before: \(before[index].backgroundImageUrl!)")
            XCTAssertNotNil(day.backgroundImageUrl, "backgroundImageUrl for \(day.dateStr) should not be nil.")
        }

        XCTAssertTrue(hasToday, "The refreshed week does not have today as a date.")
    }
}
