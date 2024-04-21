//
//  CalendarDayView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-20.
//

import SwiftUI

struct CalendarDayView: View {
    let calendarDay: CalendarDayModel

    var body: some View {
        Text(calendarDay.date)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 160, leading: 20, bottom: 20, trailing: 20))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(
                BackgroundImage(imageUrl: calendarDay.backgroundImageUrl)
            )
            .clipped()
    }
}
