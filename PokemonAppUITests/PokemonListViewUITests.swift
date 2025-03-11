//
//  PokemonListViewUITests.swift
//  PokemonAppUITests
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import XCTest

final class PokemonListViewUITests: XCTestCase {

    func testPokemonListView() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITesting"] // Custom flag for testing
        app.launch()
        
        // Check that the navigation title is correct
        let navigationBar = app.navigationBars["Pokémon List"]
        XCTAssertTrue(navigationBar.exists, "The navigation title should be 'Pokémon List'.")
        
        // Verify the list of Pokémon exists
        let firstPokemonCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstPokemonCell.exists, "The Pokémon list should load and display cells.")
        
        XCTAssertTrue(firstPokemonCell.waitForExistence(timeout: 5), "The first Pokémon cell should exist.")
        
        // Dynamically verify the first row's content
        XCTAssertTrue(firstPokemonCell.staticTexts.element.exists, "The first row should have a text element.")
    }
}
