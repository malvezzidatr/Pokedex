//
//  File.swift
//  pokedex
//
//  Created by Caio Malvezzi on 11/07/24.
//

import Foundation

struct Pokemon: Codable {
    let name: String
}

struct ListOfPokemon: Codable {
    let results: [Pokemon]
}

func fetchPokemonData(id: Int, completion: @escaping (Result<ListOfPokemon, Error>) -> Void) {
    // Definindo a URL da requisição
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=150&offset=0") else {
        print("URL inválida.")
        return
    }

    // Criando uma URLSession
    let session = URLSession.shared
    
    // Criando uma tarefa de data task para fazer a requisição
    let task = session.dataTask(with: url) { data, response, error in
        // Verificando por erros
        if let error = error {
            print("Erro ao fazer requisição: \(error.localizedDescription)")
            return
        }
        
        // Verificando se há dados de resposta
        guard let data = data else {
            let noDataError = NSError(domain: "fetchPokemonData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Não foi recebido dados a resposta."])
            completion(.failure(noDataError))
            return
        }
        
        do {
            let pokemon = try JSONDecoder().decode(ListOfPokemon.self, from: data)
            completion(.success(pokemon))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // Iniciando a tarefa de data task
    task.resume()
}
