//
//  PokeListServiceProtocol.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


protocol PokeListServiceProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse
}

final class PokeListService: PokeListServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        let endpoint = PokeListAPI.getPokemonList(limit: limit, offset: offset)
        return try await networker.requestAsync(type: PokemonListResponse.self, endPoint: endpoint)
    }
}
