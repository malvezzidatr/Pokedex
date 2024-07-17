//
//  PokemoModels.swift
//  pokedex
//
//  Created by Caio Malvezzi on 17/07/24.
//

import Foundation

struct Pokemon: Codable {
    let name: String
}

struct ListOfPokemon: Codable {
    let results: [Pokemon]
}

struct PokemonData: Codable {
    let name: String
    let sprites: Sprite
}

struct Sprite: Codable {
    let front_default: String
}
