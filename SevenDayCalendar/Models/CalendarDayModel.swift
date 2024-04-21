//
//  CalendarDayModel.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-20.
//

import Foundation

struct CalendarDayModel: Identifiable {
    let id = UUID()
    let date: String
    var backgroundImageUrl: URL?
}
