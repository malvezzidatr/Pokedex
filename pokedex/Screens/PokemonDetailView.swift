//
//  PokemonDetailView.swift
//  pokedex
//
//  Created by Caio Malvezzi on 12/07/24.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PokemonData

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Color.red
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)

            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .padding()
                .fontWeight(.bold)

            // Adicione mais detalhes sobre o Pokémon aqui
            Text("Detalhes do Pokémon")

            Spacer()
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePokemon = PokemonData(
            name: "Bulbasaur",
            sprites: Sprite(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        )

        PokemonDetailView(pokemon: examplePokemon)
    }
}
