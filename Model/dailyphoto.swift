//
//  dailyphoto.swift
//  Kosmoskart
//
//  Created by Matt R on 4/14/24.
//

// Struct to represent the response
struct DailyPhotoResponse: Codable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String? // Nullable
    let media_type: String
    let service_version: String
    let title: String
    let url: String? // Make URL optional
}


