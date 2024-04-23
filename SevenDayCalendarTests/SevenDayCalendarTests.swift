//
//  SevenDayCalendarTests.swift
//  SevenDayCalendarTests
//
//  Created by Wendy Hoy on 2024-04-18.
//

import XCTest
@testable import SevenDayCalendar

final class SevenDayCalendarTests: XCTestCase {

    // Test Wednesday, April 24, 2024
    func testCalendarWeekViewModel_init() throws {
        var components = DateComponents()
        components.year = 2024
        components.month = 4
        components.day = 17

        let input = Calendar.current.date(from: components)!
        let expected: [CalendarDayModel] = [
            CalendarDayModel(dateStr: "Sun, Apr 14"),
            CalendarDayModel(dateStr: "Mon, Apr 15"),
            CalendarDayModel(dateStr: "Tue, Apr 16"),
            CalendarDayModel(dateStr: "Wed, Apr 17"),
            CalendarDayModel(dateStr: "Thu, Apr 18"),
            CalendarDayModel(dateStr: "Fri, Apr 19"),
            CalendarDayModel(dateStr: "Sat, Apr 20")
        ]

        let actual = CalendarWeekViewModel(date: input).days

        for (index, day) in actual.enumerated() {
            XCTAssertEqual(day.dateStr, expected[index].dateStr, "A day of the week is incorrect. Actual: \(day.dateStr) Expected: \(expected[index].dateStr)")
        }
    }

    // Test backgroundImageUrls are set
    func testCalendarWeekViewModel_loadBackgroundImages() async throws {
        let week = CalendarWeekViewModel(date: Date.now)
        let input = week.days

        await week.loadBackgroundImages(calendarDays: input)

        for day in week.days {
            XCTAssertNotNil(day.backgroundImageUrl, "backgroundImageUrl for \(day.dateStr) should not be nil.")
        }
    }

    // Test dates and backgroundImageUrls are updated
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
