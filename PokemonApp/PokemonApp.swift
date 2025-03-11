//
//  PokemonApp.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import SwiftUI

@main
struct PokemonApp: App {
    var body: some Scene {
        WindowGroup {
            let isUITesting = CommandLine.arguments.contains("-UITesting")
            let service: PokemonServiceProtocol = isUITesting ? MockPokemonService() : PokemonService()
            PokemonListView(viewModel: PokemonListViewModel(service: service))
        }
    }
}
