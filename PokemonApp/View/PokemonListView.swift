//
//  PokemonListView.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel: PokemonListViewModel
    @State private var didNavigate: Bool = false
    
    init(viewModel: PokemonListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.pokemons.isEmpty {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .accessibilityIdentifier("progressView")
                } else {
                    List(viewModel.pokemons.indices, id: \.self) { index in
                        let pokemon = viewModel.pokemons[index]
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonRow(pokemon: pokemon)
                                .accessibilityIdentifier("pokemonCell-\(pokemon.name)")
                                .onAppear {
                                    // Check if this is the last item and load more if needed
                                    if index == viewModel.pokemons.count - 1 {
                                        Task {
                                            await viewModel.loadMorePokemons()// Load more when the last item appears
                                        }
                                    }
                                }
                        }
                    }
                    .accessibilityIdentifier("pokemonList")
                }
            }
            .navigationTitle("Pokémon List")
            .onDisappear{
                didNavigate = true
            }
            .onAppear {
                if !didNavigate {
                    Task {
                        await viewModel.loadPokemons()// Initial fetch when view appears
                    }
                }
            }
        }
        .accentColor(.black)
    }
}

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            if let imageUrl = pokemon.sprites?.frontDefault, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
            } else {
                Color.gray
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                Text("Number of abilities:  \(pokemon.abilities?.count ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
        .padding()
    }
}



#Preview {
    PokemonListView(viewModel: PokemonListViewModel())
}
