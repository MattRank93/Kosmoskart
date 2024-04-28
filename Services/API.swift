import Foundation

class API {
    static func getDailyPhoto(bearerToken: String, completion: @escaping (Result<DailyPhotoResponse, Error>) -> Void) {
        // Create URL
        guard let url = URL(string: "http://192.168.0.111:8080/integrations/daily-photo") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add authorization header
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        // Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dailyPhotoResponse = try decoder.decode(DailyPhotoResponse.self, from: data)
                completion(.success(dailyPhotoResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start URLSession task
        task.resume()
    }
    
    
    
    
    static func getUserTelescopes(bearerToken: String, completion: @escaping (Result<[TelescopeProfile], Error>) -> Void) {
        // Create URL
        guard let url = URL(string: "http://192.168.0.111:8080/telescopes/by-userid") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "userId": 1
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        // Add authorization header
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        // Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let telescopeListResponse = try decoder.decode([TelescopeProfile].self, from: data)
                completion(.success(telescopeListResponse))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
        }
        
        // Start URLSession task
        task.resume()
    }

    
    
}

enum APIError: Error {
    case invalidURL
    case noData
    case invalidResponse
}
