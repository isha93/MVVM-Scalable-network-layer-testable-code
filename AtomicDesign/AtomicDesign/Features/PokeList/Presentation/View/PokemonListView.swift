//
//  PokemonListView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

struct PokemonListView: View {
    @Environment(AppRouter.self) var router
    @State var viewModel: PokemonListViewModel
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView("Catching Pokemons...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
            } else {
                ForEach(viewModel.pokemons) { pokemon in
                    Button {
                        router.push(.detail(name: pokemon.name))
                    } label: {
                        PokemonRow(pokemon: pokemon)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Pokedex")
        .task {
            await viewModel.loadData()
        }
    }
}
