//
//  ContentView.swift
//  pokedex
//
//  Created by Caio Malvezzi on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemonsDatas: [PokemonData] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if pokemonsDatas.isEmpty {
                    ProgressView("Carregando pokemons...")
                } else {
                    Text("Pokedex")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 60)
                    Spacer(minLength: 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(pokemonsDatas, id: \.name) { pokemon in
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
            }
            .onAppear {
                self.getPokemonData()
            }
        }
    }
    
    private func getPokemonData() {
        for index in 1...150 {
            fetchPokemon(id: index) { result in
                switch result {
                case .success(let pokemonData):
                    DispatchQueue.main.async {
                        self.pokemonsDatas.append(pokemonData)
                    }
                    
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            }
        }
    }
}

struct PokemonCard: View {
    var pokemon: PokemonData
    
    var body: some View {
        VStack {
            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                VStack {
                    AsyncImage(url: URL(string: pokemon.sprites.front_default)) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 280, height: 300)
                        
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 32))
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
