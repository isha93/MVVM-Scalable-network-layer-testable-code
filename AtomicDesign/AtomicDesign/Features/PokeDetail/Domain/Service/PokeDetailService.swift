//
//  HomeServiceProtocol.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


protocol PokeDetailServiceProtocol {
    func fetchPokemonsDetail(name: String) async throws -> PokemonDetail
}

final class PokeDetailService: PokeDetailServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func fetchPokemonsDetail(name: String) async throws -> PokemonDetail {
        let endpoint = PokeDetailAPI.getPokemonDetail(name: name)
        return try await networker.requestAsync(type: PokemonDetail.self, endPoint: endpoint)
    }
}
