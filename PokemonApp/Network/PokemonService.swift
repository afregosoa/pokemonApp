//
//  PokemonService.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import Foundation

class PokemonService: PokemonServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
      
      init(networkService: NetworkServiceProtocol = NetworkService.shared) {
          self.networkService = networkService
      }
      
      // Function to fetch list of Pokémon from the PokeAPI
      func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
          let url = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
          
          let response: PokemonListResponse = try await networkService.fetchData(from: url, modelType: PokemonListResponse.self)
          return try await fetchDetailsForPokemons(pokemons: response.results)
      }
      
      // Function to fetch details for each Pokémon (including image URL)
      private func fetchDetailsForPokemons(pokemons: [Pokemon]) async throws -> [Pokemon] {
          var updatedPokemons = pokemons  // Mutable copy
          
          for (index, pokemon) in pokemons.enumerated() {
              let detail: PokemonDetail = try await networkService.fetchData(from: pokemon.url, modelType: PokemonDetail.self)
              updatedPokemons[index].sprites = detail.sprites
              updatedPokemons[index].abilities = detail.abilities
          }
          
          return updatedPokemons
      }
}
