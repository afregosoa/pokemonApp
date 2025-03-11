//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(spacing: 20) {
            HorizontalImageScrollView(imageUrls: [pokemon.sprites?.frontDefault ?? "", pokemon.sprites?.backDefault ?? "", pokemon.sprites?.backShiny ?? ""])
                .frame(height: 180) // Set the height of the collection
                .accessibilityIdentifier("pokemonImageScrollView")
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("pokemonName")
            
            Text("Description")
                .font(.body)
                .italic()
                .padding()
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("pokemonDescription")
            
            if !(pokemon.abilities?.isEmpty ?? false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Abilities")
                        .font(.headline)
                        .padding(.top)
                        .accessibilityIdentifier("abilitiesHeader")
                    
                    ForEach(pokemon.abilities ?? [], id: \.id) { ability in
                        Text("- \(ability.ability.name)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("ability-\(ability.ability.name)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon(name: "", url: ""))
}
