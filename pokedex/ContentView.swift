//
//  ContentView.swift
//  pokedex
//
//  Created by Caio Malvezzi on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            fetchPokemonData(id: 3)
        }
    }
}

#Preview {
    ContentView()
}
