//
//  PokemoViewModel.swift
//  pokedex
//
//  Created by Caio Malvezzi on 17/07/24.
//

import Foundation
import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemonsDatas: [PokemonData] = []
    @Published var filteredPokemons: [PokemonData] = []
    @Published var pokemonName: String = ""
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let pokemonService = PokemonService()
    
    init() {
        getPokemonData()
    }
    
    func getPokemonData() {
        for index in 1...150 {
            pokemonService.fetchPokemon(id: index) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let pokemonData):
                    DispatchQueue.main.async {
                        self.pokemonsDatas.append(pokemonData)
                        self.filteredPokemons = self.pokemonsDatas
                        self.isLoading = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            }
        }
        
    }
    
    func handleTextChanged(_ pokemonSearched: String) {
        if pokemonSearched.isEmpty {
            filteredPokemons = pokemonsDatas
        } else {
            filteredPokemons = pokemonsDatas.filter { $0.name.lowercased().contains(pokemonSearched.lowercased()) }
        }
    }
}
