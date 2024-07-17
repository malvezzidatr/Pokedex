import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Carregando pokémons...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    PokedexTitle()
                    Spacer(minLength: 50)
                    SearchPokemonTextField(pokemonName: $viewModel.pokemonName, viewModel: viewModel)
                    Spacer(minLength: 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.filteredPokemons.isEmpty ? viewModel.pokemonsDatas : viewModel.filteredPokemons, id: \.name) { pokemon in
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
            }
        }
    }
}

struct PokedexTitle: View {
    var body: some View {
        Text("Pokedex")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.top, 60)
    }
}

struct SearchPokemonTextField: View {
    @Binding var pokemonName: String
    @ObservedObject var viewModel: PokemonViewModel

    var body: some View {
        TextField("Enter pokemon name", text: $pokemonName)
            .onChange(of: pokemonName, perform: { pokemonSearched in
                viewModel.handleTextChanged(pokemonSearched)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.gray, width: 1)
            .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
