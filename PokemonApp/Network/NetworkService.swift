//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // Generic method for fetching data from an API using async/await
    func fetchData<T: Decodable>(from url: String, modelType: T.Type) async throws -> T {
        
        // Ensure the URL is valid
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        // Perform the data fetch using async/await
        let (data, response) = try await session.data(from: url)
        
        // Ensure the response has a valid HTTP status code
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        // Decode the response data into the expected model
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// Custom errors for NetworkService
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case invalidStatusCode(Int)
}
