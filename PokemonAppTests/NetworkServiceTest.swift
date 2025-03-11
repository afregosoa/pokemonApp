//
//  NetworkServiceTest.swift
//  PokemonAppTests
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import XCTest
@testable import PokemonApp

final class NetworkServiceTest: XCTestCase {
    
    var networkService: NetworkService!
    var session: URLSession!
    
    override func setUp() {
        super.setUp()
        
        // Configure URLSession with MockURLProtocol
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
        
        // Inject mock session into the service
        networkService = NetworkService(session: session)
    }
    
    override func tearDown() {
        MockURLProtocol.testData = nil
        MockURLProtocol.testResponse = nil
        MockURLProtocol.testError = nil
        networkService = nil
        session = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() async throws {
        // Prepare mock data
        let testData = """
            {
                "name": "Pikachu",
                "url": "pikachu.com"
            }
            """.data(using: .utf8)
        
        MockURLProtocol.testData = testData
        MockURLProtocol.testResponse = HTTPURLResponse(
            url: URL(string: "https://mock.api/pokemon")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // Act
        do {
            let pokemon: Pokemon = try await networkService.fetchData(from: "https://mock.api/pokemon", modelType: Pokemon.self)
            
            // Assert
            XCTAssertEqual(pokemon.name, "Pikachu")
        } catch {
            XCTFail("Expected success but got failure: \(error)")
        }
    }
}
