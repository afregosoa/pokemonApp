//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    var imageUrl: String?
    var sprites: Sprites?
    var abilities: [Ability]?
    
    private enum CodingKeys: String, CodingKey {
        case name, url, imageUrl, sprites, abilities
    }
}

struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

// Structs to match the response from the PokeAPI
struct PokemonListResponse: Decodable {
    let results: [Pokemon]
}

struct PokemonDetail: Decodable {
    let sprites: Sprites
    let abilities: [Ability]
}

struct Ability: Decodable, Identifiable {
    let id = UUID()
    let ability: AbilityDetails
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct AbilityDetails: Codable {
    let name: String
}

struct Sprites: Decodable {
    let frontDefault: String?
    let backDefault: String?
    let backShiny: String?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
    }
}
