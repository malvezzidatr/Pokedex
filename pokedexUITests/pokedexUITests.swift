//
//  pokedexUITests.swift
//  pokedexUITests
//
//  Created by Caio Malvezzi on 11/07/24.
//

import XCTest

final class pokedexUITests: XCTestCase {
    
    enum SwipeDirection {
        case right
        case left
    }
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfPokemonCardIsCorrectlyAndReturnToHome() throws {
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
        XCTAssertTrue(pokemonName.exists, "O texto não está presente na tela.")
        
        returnToPreviousScreen()
    }
    
    func testIfScrollIsWorking() throws {
        app.launch()
        
        let scrollView = app.scrollViews.element(boundBy: 0)
        XCTAssertTrue(scrollView.exists, "O scroll view não está presente na tela.")
        
        swipeHowManyTimes(direction: .left, times: 3)
        
        let pokemon = app.staticTexts["Squirtle"]
        XCTAssertTrue(pokemon.exists, "O pokemon não foi encontrado.")
    }
    
    func testPokemonSearchInput() throws {
        app.launch()
        
        let textInputField = app.textFields["Search pokemon"]
        XCTAssertTrue(textInputField.exists, "O text input não foi encontrado.")
        
        textInputField.tap()
        textInputField.typeText("Zapdos")
        XCTAssertEqual(textInputField.value as? String, "Zapdos")
        
        let pokemon = app.staticTexts["Zapdos"]
        XCTAssertTrue(pokemon.exists, "Pokemon não encontrado.")
        
        pokemon.tap()
        
        let pokemonType1 = app.staticTexts["Electric"]
        let pokemonType2 = app.staticTexts["Flying"]
        XCTAssertTrue(pokemonType1.exists, "Tipo do pokemon não encontrado.")
        XCTAssertTrue(pokemonType2.exists, "Tipo do pokemon não encontrado.")
        
        returnToPreviousScreen()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func returnToPreviousScreen() {
        let backButton = app.navigationBars.buttons["Back"]
        if backButton.exists {
            backButton.tap()
        } else {
            XCTFail("O botão 'Voltar' não foi encontrado.")
        }
    }
    
    func swipeHowManyTimes(direction: SwipeDirection, times: Int) {
        switch direction {
            case .right:
                for _ in 0..<times {
                    app.swipeRight()
                }
            case .left:
                for _ in 0..<times {
                    app.swipeLeft()
                }
            }
    }
}
