//
//  SaveTelescopeRequest.swift
//  Kosmoskart
//
//  Created by Matt R on 4/28/24.
//

import Foundation


struct TelescopeRequest: Codable {
    let userId: Int
    let nameModel: String
    let manufacturer: String?
    let type: String?
    let aperture: Decimal
    let focalLength: Int?
    let focalRatio: Decimal?
    let mountType: String?
    let maximumUsefulMagnification: Int?
    let limitingStellarMagnitude: Decimal?
}
