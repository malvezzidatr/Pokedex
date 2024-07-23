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
                
            PokemonName(name: pokemon.name)
            
            Spacer().frame(height: 6)
            
            HStack(spacing: 14) {
                ForEach(pokemon.types, id: \.type.name) {
                    type in PokemonTypeCard(type: type.name)
                    
                }
            }
            
            Spacer().frame(height: 60)
            Text("Moves:")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}

struct PokemonName: View {
    var name: String
    
    var body: some View {
            Text(name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
    }
}

struct PokemonTypeCard: View {
    var type: String
    var colorOfType: String = "blue"
    
    let pokemonTypeColors: [String: Color] = [
        "fire": .red,
        "water": .blue,
        "grass": .green,
        "electric": .yellow,
        "psychic": .purple,
        "ice": .cyan,
        "dragon": .orange,
        "dark": .black,
        "fairy": .pink,
        "normal": .gray,
        "fighting": .brown,
        "poison": .purple,
        "flying": .teal,
        "bug": .secondary,
        "ghost": .indigo,
    ]
    
    var body: some View {
        Text(type.capitalized)
            .padding(4)
            .padding(.trailing, 8)
            .padding(.leading, 8)
            .background(pokemonTypeColors[type.lowercased()] ?? .gray)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.headline)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePokemon = PokemonData(
            name: "Bulbasaur",
            sprites: Sprite(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [
                PokemonTypes(type: TypeObject(name: "Grass")),
                PokemonTypes(type: TypeObject(name: "Poison"))
            ]
        )

        PokemonDetailView(pokemon: examplePokemon)
    }
}
