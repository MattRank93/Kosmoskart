//
//  Utils.swift
//  Kosmoskart
//
//  Created by Matt R on 4/11/24.
//

import Foundation
import SwiftUI

struct LoginManager {
    static func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://192.168.0.111:8080/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Login successful
                    if let jwt = parseJWT(from: data) {
                        // Store JWT securely
                        KeychainService.saveToken(jwt)
                        completion(true)
                    } else {
                        print("Failed to parse JWT")
                        completion(false)
                    }
                } else {
                    print("HTTP status code: \(httpResponse.statusCode)")
                    // Handle other status codes (e.g., 401 for unauthorized)
                    completion(false)
                }
            }
        }.resume()
    }

    static func parseJWT(from data: Data) -> String? {
        // Parse JWT from data
        // Example: if JWT is in JSON response {"token": "your_token_here"}
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return json["token"] as? String
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
        return nil
    }
}



struct KeychainService {
    static let service = "YourAppName"

    static func saveToken(_ token: String) {
        let tokenData = token.data(using: .utf8)!
        
        // Create a query dictionary
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecValueData as String: tokenData
        ]
        
        // Delete any existing token
        SecItemDelete(query as CFDictionary)
        
        // Add the new token
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Error saving token: \(status)")
            return
        }
        
        print("Token saved successfully")
    }
}


