//
//  pokedexUITests.swift
//  pokedexUITests
//
//  Created by Caio Malvezzi on 11/07/24.
//

import XCTest

final class pokedexUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfPokemonCardIsCorrectly() throws {
        let app = XCUIApplication()
        app.launch()
        
        let pokemonName = app.staticTexts["Bulbasaur"]
        let pokemonImage = app.images["PokemonImage"]
        XCTAssertTrue(pokemonName.exists, "O texto não está presente na tela.")
        XCTAssertTrue(pokemonImage.exists, "A imagem não está presente na tela.")
        pokemonName.tap()
        
        let pokemonTypeGrass = app.staticTexts["Grass"]
        let pokemonTypePoison = app.staticTexts["Poison"]
        XCTAssertTrue(pokemonTypeGrass.exists, "O texto 'grass' não está presente na tela.")
        XCTAssertTrue(pokemonTypePoison.exists, "O texto 'posion' não está presente na tela.")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
