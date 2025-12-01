//
//  PokemonListViewModel.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

@Observable
class PokemonListViewModel {
    var pokemons: [Pokemon] = []
    var isLoading: Bool = false
    
    private let pokeListService: PokeListServiceProtocol
    
    init(pokeListService: PokeListServiceProtocol = PokeListService()) {
        self.pokeListService = pokeListService
    }
    
    func loadData() async {
        self.isLoading = true
        defer { isLoading = false }
        do {
            let response = try await pokeListService.fetchPokemons(limit: 100, offset: 0)
            self.pokemons = response.results
            self.isLoading = false
        } catch {
            //TODO: handle error
        }
    }
}
