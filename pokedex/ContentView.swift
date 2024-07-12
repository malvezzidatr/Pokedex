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
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                        .padding(.top, 60)
                    Spacer(minLength: 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(pokemonsDatas, id: \.name) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    VStack {
                                        AsyncImage(url: URL(string: pokemon.sprites.front_default)) { result in
                                            result.image?.resizable()
                                                .scaledToFill()
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
                    }.padding(.leading, 10)
                    Spacer()
                }
            }
            
            .onAppear {
                let dispatchGroup = DispatchGroup()
                
                for index in 1...150 {
                    dispatchGroup.enter()
                    fetchPokemon(id: index) { result in
                        defer {
                            dispatchGroup.leave()
                        }
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
        
    }
}

#Preview {
    ContentView()
}
