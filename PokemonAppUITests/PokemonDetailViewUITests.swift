//
//  PokemonDetailViewUITests.swift
//  PokemonAppUITests
//
//  Created by Alfredo Fregoso on 19/12/24.
//

import XCTest

final class PokemonDetailViewUITests: XCTestCase {

    func testPokemonDetailViewUI() {
        let app = XCUIApplication()
        app.launch()
        
        let firstPokemonCell = app.cells.element(boundBy: 0) // Index 0 for the first cell
        XCTAssertTrue(firstPokemonCell.exists, "The first Pokémon cell should exist.")
        firstPokemonCell.tap()
        
        let imageScrollView = app.scrollViews["pokemonImageScrollView"]
        XCTAssertTrue(imageScrollView.exists, "Image scroll view should exist")
        
        let nameLabel = app.staticTexts["pokemonName"]
        XCTAssertTrue(nameLabel.exists, "Pokemon name label should exist")
        XCTAssertEqual(nameLabel.label, "Bulbasaur") // Replace with test data
        
        let descriptionLabel = app.staticTexts["pokemonDescription"]
        XCTAssertTrue(descriptionLabel.exists, "Description label should exist")
        
        let abilitiesHeader = app.staticTexts["abilitiesHeader"]
        XCTAssertTrue(abilitiesHeader.exists, "Abilities header should exist")
    }
}
