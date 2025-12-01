//
//  PokemonDetailViewModel.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

@Observable
class PokemonDetailViewModel {
    var pokemon: PokemonDetail?
    var isLoading: Bool = false    
    private let pokeDetailService: PokeDetailServiceProtocol
    
    init(pokeDetailService: PokeDetailServiceProtocol = PokeDetailService()) {
        self.pokeDetailService = pokeDetailService
    }
    
    func loadDetail(name: String) async {
        self.isLoading = true
        defer { isLoading = false }
        do {
            let response = try await pokeDetailService.fetchPokemonsDetail(name: name)
            self.pokemon = response
            self.isLoading = false
        } catch {
            //TODO: handle error
            print(error)
        }
    }
}
