//
//  CuteAnimalsApi.swift
//  SevenDayCalendar
//
//  Created by Wendy Hoy on 2024-04-19.
//

import Foundation

struct CuteAnimal: Codable {
    var id: String
    var url: String
    var width: UInt
    var height: UInt
}

class CuteAnimalsApi {
    let urlString = "https://api.thecatapi.com/v1/images/search?limit=10"
    
    enum ApiError: Error {
        case invalidUrl
        case failedRequest
        case notEnoughImages
    }
    
    func getImageUrls(numImages: UInt) async throws -> [URL?] {
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.failedRequest }
        
        let jsonData = try JSONDecoder().decode([CuteAnimal].self, from: data)
        guard jsonData.count >= numImages else { throw ApiError.notEnoughImages }
        
        let imageUrls = jsonData
            .dropLast(jsonData.count-Int(numImages))
            .map { URL(string: $0.url) }
        
        return imageUrls
    }
}
