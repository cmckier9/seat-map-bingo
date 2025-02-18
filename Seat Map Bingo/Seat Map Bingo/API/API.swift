//
//  API.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/23/24.
//

import Foundation

class API {
    static let shared = API()
    
    private init() {}
    
    // Function to fetch data from a specific endpoint
    func fetchData(from endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            
            completion(.success(data))
        }
        task.resume()
    }
    
    func postData(for endpoint: String, _ data: UserSeatHistoryPost, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        guard let uploadData = try? JSONEncoder().encode(data) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
        task.resume()
    }
    
    // Custom error types for better error handling
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case noData
    }
}

