////
////  API.swift
////  Kosmoskart
////
////  Created by Matt R on 4/11/24.
////
//
//import Foundation
//
//struct API {
//    static func fetchData(using token: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        let urlString = "http://192.168.0.111:8080/integrations/jwt-test"
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
//                return
//            }
//
//            guard (200...299).contains(httpResponse.statusCode) else {
//                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
//                return
//            }
//
//            if let data = data {
//                completion(.success(data))
//            } else {
//                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
//            }
//        }
//
//        task.resume()
//    }
//}
//
//// Example usage:
//let jwtToken = "your_jwt_token_here"
//
//API.fetchData(using: jwtToken) { result in
//    switch result {
//    case .success(let data):
//        // Handle successful response data
//        print("Received data:", data)
//    case .failure(let error):
//        // Handle error
//        print("Error:", error)
//    }
//}
