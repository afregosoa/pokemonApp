//
//  MockPokemonService.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import Foundation

class MockPokemonService: PokemonServiceProtocol {
    var shouldFail: Bool = false
    var pokemons: [Pokemon] = [Pokemon(name: "Pikachu", url: "pikachu.com")]
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        if shouldFail {
            // Simulate an error by throwing an NSError
            let error = NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch pokemons"])
            throw error
        } else {
            // Return the mocked list of pokemons
            return pokemons
        }
    }
}
