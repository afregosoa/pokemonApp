//
//  PokemonListViewModel.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import Combine
import Foundation

class PokemonListViewModel: PokemonListViewModelProtocol {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isFetchingMore: Bool = false

    private let service: PokemonServiceProtocol
    private var limit = 20
    private var offset = 0
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }

    func loadPokemons() async {
        guard !isLoading else { return }
        
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
         }
        
        do {
             // Fetch pokemons using async/await
             let newPokemons = try await service.fetchPokemons(limit: limit, offset: offset)
             // Update the UI on the main thread
            await MainActor.run {
                 self.pokemons = newPokemons
                 self.offset = self.pokemons.count
                 self.isLoading = false
             }
         } catch {
             // Handle the error and update the errorMessage
             await MainActor.run {
                 self.errorMessage = error.localizedDescription
                 self.isLoading = false
             }
         }
    }
    
    func loadMorePokemons() async {
        guard !isFetchingMore else { return }
        await MainActor.run {
            isFetchingMore = true
            errorMessage = nil
        }
        
        do {
            // Fetch more pokemons using async/await
            let newPokemons = try await service.fetchPokemons(limit: limit, offset: offset)
            // Update the UI on the main thread
            await MainActor.run {
                self.pokemons.append(contentsOf: newPokemons)
                self.offset = self.pokemons.count
                self.isFetchingMore = false
            }
        } catch {
            // Handle the error and update the errorMessage
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isFetchingMore = false
            }
        }
    }
}
