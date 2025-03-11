//
//  NetworkServiceProtocol.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(
        from url: String,
        modelType: T.Type
    ) async throws -> T
}
