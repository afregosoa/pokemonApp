//
//  PokemonServiceProtocol.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
}
