//
//  PokemonListViewModelTests.swift
//  PokemonAppTests
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import XCTest
@testable import PokemonApp

final class PokemonListViewModelTests: XCTestCase {
    
    var mockService: MockPokemonService!
    var viewModel: PokemonListViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockPokemonService()
        viewModel = PokemonListViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadPokemonsSuccess() async {
        // Given
        mockService.pokemons = [
            Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"),
            Pokemon(name: "Charmander", url: "https://pokeapi.co/api/v2/pokemon/4")
        ]
        
        // When
        await viewModel.loadPokemons()
        
        // Then
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.pokemons.count, 2)
            XCTAssertNil(self.viewModel.errorMessage)
    }
    
    func testLoadPokemonsFailure() async {
        // Given
        mockService.shouldFail = true

        // When
        await viewModel.loadPokemons()

        // Then
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.pokemons.count, 0)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.errorMessage, "Failed to fetch pokemons")
    }
    
    func testLoadMorePokemonsSuccess() async {
        // Given
        mockService.pokemons = [
            Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"),
            Pokemon(name: "Charmander", url: "https://pokeapi.co/api/v2/pokemon/4")
        ]
        viewModel.pokemons = [
            Pokemon(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25")
        ]

        // When
        await viewModel.loadMorePokemons()

        // Then
            XCTAssertFalse(self.viewModel.isFetchingMore)
            XCTAssertEqual(self.viewModel.pokemons.count, 3)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.pokemons[2].name, "Charmander")
    }
    
    func testLoadMorePokemonsFailure() async {
        // Given
        mockService.shouldFail = true
        viewModel.pokemons = [
            Pokemon(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25")
        ]

        // When
        await viewModel.loadMorePokemons()

        // Then
            XCTAssertFalse(self.viewModel.isFetchingMore)
            XCTAssertEqual(self.viewModel.pokemons.count, 1)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.errorMessage, "Failed to fetch pokemons")
    }
}
