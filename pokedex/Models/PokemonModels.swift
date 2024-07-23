//
//  PokemoModels.swift
//  pokedex
//
//  Created by Caio Malvezzi on 17/07/24.
//

import Foundation

struct ListOfPokemon: Codable {
    let results: [PokemonData]
}

struct PokemonData: Codable {
    let name: String
    let sprites: Sprite
    let types: [PokemonTypes]
}

struct PokemonTypes: Codable {
    let type: TypeObject
}

extension PokemonTypes {
    var name: String {
        return type.name
    }
}
struct TypeObject: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String
}
