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


 func fetchData(using token: String, completion: @escaping (Result<Data, Error>) -> Void) {
    let urlString = "http://192.168.0.111:8080/integrations/jwt-test"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
            return
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
            return
        }

        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
        }
    }

    task.resume()
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


