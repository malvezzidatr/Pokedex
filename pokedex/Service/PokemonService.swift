//
//  File.swift
//  pokedex
//
//  Created by Caio Malvezzi on 11/07/24.
//

import Foundation

class PokemonService {
    func fetchPokemon(id: Int, completion: @escaping (Result<PokemonData, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            print("URL inválida")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro ao fazer requisição: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "fetchPokemonData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Não foi recebido dados."])
                completion(.failure(noDataError))
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                completion(.success(pokemonData))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
