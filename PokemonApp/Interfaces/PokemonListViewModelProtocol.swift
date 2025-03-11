//
//  PokemonListViewModelProtocol.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import Foundation

protocol PokemonListViewModelProtocol: ObservableObject {
    var pokemons: [Pokemon] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    var isFetchingMore: Bool { get set }

    func loadPokemons() async
    func loadMorePokemons() async
}
