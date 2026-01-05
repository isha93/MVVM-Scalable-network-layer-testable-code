//
//  MockPokeListService.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import Foundation
@testable import AtomicDesign

class MockPokeListService: PokeListServiceProtocol {
    enum Mode { case success, failure(Error) }
    var mode: Mode = .success
    var mockResponse: PokemonListResponse?
    var callCount: Int = 0
    var lastLimit: Int?
    var lastOffset: Int?

    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        callCount += 1
        lastLimit = limit
        lastOffset = offset

        switch mode {
        case .success:
            guard let response = mockResponse else {
                return PokemonListResponse(count: 0, next: nil, previous: nil, results: [])
            }
            return response
        case .failure(let error):
            throw error
        }
    }
}
