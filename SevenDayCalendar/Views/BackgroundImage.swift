//
//  BackgroundImage.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-20.
//

import SwiftUI

/// Asynchronously loads and displays the background image for the day.
struct BackgroundImage: View {
    var imageUrl: URL?

    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Text("Sorry, image is unavailable.")
                Color
                    .gray
                    .opacity(0.3)
            } else {
                ProgressView()
            }
        }
    }
}
