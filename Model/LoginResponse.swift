//
//  LoginResponse.swift
//  Kosmoskart
//
//  Created by Matt R on 4/14/24.
//

import Foundation


struct LoginResponse: Codable {
    let token: String
    let type: String
}
