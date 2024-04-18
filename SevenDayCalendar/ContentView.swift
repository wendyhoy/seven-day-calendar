//
//  ContentView.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-18.
//

import SwiftUI

struct ContentView: View {
    let daysOfTheWeek: [String] = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ]
    
    var body: some View {
        VStack {
            Text("Cute Animal Seven-Day Calendar")
                .font(.headline)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(daysOfTheWeek, id: \.description) {
                        day in Text(day)
                            .font(.largeTitle)
                            .padding(80)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle()
                                .fill(.red))
                            .border(.black)
                    }
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    ContentView()
}
