//
//  MockURLProtocol.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var testError: Error?
    static var testResponse: HTTPURLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.testError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if let response = MockURLProtocol.testResponse, let data = MockURLProtocol.testData {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
        } else {
            self.client?.urlProtocol(self, didFailWithError: NetworkError.noData)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // No cleanup required for mocking
    }
}
