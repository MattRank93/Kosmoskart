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
                    do {
                        let jwtResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        print("jwtResponse: \(jwtResponse.token)")

                        // Store JWT securely
                        KeychainService.saveToken(jwtResponse.token)
                        completion(true)
                    } catch {
                        print("Error decoding JWT response: \(error.localizedDescription)")
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


    
    static func register(user: UserModel, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://192.168.0.111:8080/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "username": user.username,
            "firstname": user.firstname,
            "lastname": user.lastname,
            "email": user.email,
            "password": user.password
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("The parameters being sent in: \(jsonString)")
        } else {
            print("Failed to convert parameters to JSON string")
        }

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Registration successful
                    completion(true)
                } else {
                    print("HTTP status code: \(httpResponse.statusCode)")
                    // Handle other status codes if needed
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
    static let service = "KosmosKartan"

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
    
    
    static func retrieveToken() -> String? {
        
        print("fetching token from keystore")

        // Create a query dictionary for retrieving the token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var tokenData: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &tokenData)
        guard status == errSecSuccess else {
            print("Error retrieving token: \(status)")
            return nil
        }
        
        guard let data = tokenData as? Data else {
            print("Error converting token data")
            return nil
        }
        
        guard let token = String(data: data, encoding: .utf8) else {
            print("Error decoding token data")
            return nil
        }
        
        return token
    }
    
    
    
    
    func decodeJWT(_ token: String) -> String? {
        let segments = token.components(separatedBy: ".")
        guard segments.count > 1 else {
            print("Invalid token: Not enough segments")
            return nil
        }

        var base64String = segments[1]
        if base64String.count % 4 != 0 {
            let padLength = 4 - base64String.count % 4
            base64String += String(repeating: "=", count: padLength)
        }

        guard let data = Data(base64Encoded: base64String) else {
            print("Error decoding base64")
            return nil
        }

        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            print("Invalid JSON")
            return nil
        }

        return json["id"] as? String
    }
    
    
    
}


