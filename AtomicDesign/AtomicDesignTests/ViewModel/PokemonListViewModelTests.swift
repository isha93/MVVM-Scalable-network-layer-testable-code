//
//  PokemonListViewModelTests.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/05.
//

import XCTest
@testable import AtomicDesign

final class PokemonListViewModelTests: XCTestCase {
    
    // MARK: - Mock Service
    // As described in "Round 1" of the article, we use a controlled mock.
    class MockPokeListService: PokeListServiceProtocol {
        // We control reality here.
        var shouldThrow = false
        var mockResponse = PokemonListResponse.mock()

        func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
            if shouldThrow {
                // Team Rocket is attacking!
                throw APIRequestError.badRequest(message: "Invalid request")
            }
            return mockResponse
        }
    }
    
    // MARK: - Tests

    // MOVE 1: The Happy Path
    func test_loadData_validRequest_shouldSetPokemons() async {
        // Given: The world is peaceful
        let mock = MockPokeListService()
        mock.mockResponse = PokemonListResponse.mock()
        let vm = PokemonListViewModel(pokeListService: mock)

        // When: We ask for data
        await vm.loadData()

        // Then: It's super effective!
        XCTAssertEqual(vm.pokemons.count, 1)
        XCTAssertEqual(vm.pokemons.first?.name, "pikachu")
        XCTAssertFalse(vm.isLoading)
    }

    // MOVE 2: The Error Boundary (Defending against critical hits)
    func test_loadData_serviceThrows_shouldNotCrashAndStopLoading() async {
        // Given: Chaos ensues
        let mock = MockPokeListService()
        mock.shouldThrow = true // Force the error
        let vm = PokemonListViewModel(pokeListService: mock)

        // When: We try to load data
        await vm.loadData()

        // Then: We are still standing
        XCTAssertEqual(vm.pokemons.count, 0) // No data, but no crash
        XCTAssertFalse(vm.isLoading) // Spinner should stop, or user will rage-quit
    }
}
