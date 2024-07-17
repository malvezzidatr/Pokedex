import SwiftUI

struct ContentView: View {
    @State private var pokemonsDatas: [PokemonData] = []
    @State private var filteredPokemons: [PokemonData] = []
    @State private var pokemonName: String = ""
    
    var body: some View {
        VStack {
            Text("Pokedex")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 60)
            Spacer(minLength: 50)
            SearchPokemonTextField(pokemonName: $pokemonName, pokemonsDatas: $pokemonsDatas, filteredPokemons: $filteredPokemons)
            NavigationView {
                VStack {
                    if pokemonsDatas.isEmpty {
                        ProgressView("Carregando pokemons...")
                    } else {
                        Spacer(minLength: 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(filteredPokemons.isEmpty ? pokemonsDatas : filteredPokemons, id: \.name) { pokemon in
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
    }
    
    private func getPokemonData() {
        for index in 1...150 {
            fetchPokemon(id: index) { result in
                switch result {
                case .success(let pokemonData):
                    DispatchQueue.main.async {
                        self.pokemonsDatas.append(pokemonData)
                        self.filteredPokemons = self.pokemonsDatas
                    }
                    
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            }
        }
    }
}

struct SearchPokemonTextField: View {
    @Binding var pokemonName: String
    @Binding var pokemonsDatas: [PokemonData]
    @Binding var filteredPokemons: [PokemonData]
    
    var body: some View {
        TextField("Enter pokemon name", text: $pokemonName)
            .onChange(of: pokemonName, perform: { pokemonSearched in
                handleTextChanged(pokemonSearched)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.gray, width: 1)
            .padding()
    }
    
    private func handleTextChanged(_ pokemonSearched: String) {
        if pokemonSearched.isEmpty {
            filteredPokemons = pokemonsDatas
        } else {
            filteredPokemons = pokemonsDatas.filter { $0.name.lowercased().contains(pokemonSearched.lowercased()) }
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
                .background(Color.gray)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
