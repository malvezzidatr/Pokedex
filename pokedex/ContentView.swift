//
//  ContentView.swift
//  pokedex
//
//  Created by Caio Malvezzi on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            fetchPokemonData(id: 3) { result in
                switch result {
                case .success(let listOfPokemon):
                    print("Lista de pokemons:", listOfPokemon)
                case .failure(let error):
                    print("Erro ao buscar dados dos pokemons:", error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
