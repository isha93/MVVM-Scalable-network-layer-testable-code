//
//  PokemonDetailViewModelTests.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/05.
//

//
//  PokemonDetailViewModelTests.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/05.
//

import XCTest
@testable import AtomicDesign

final class PokemonDetailViewModelTests: XCTestCase {
    
    // MARK: - Mock Service
    // We define the mock here to strictly control the "Modes" of failure/success
    class MockPokeDetailService: PokeDetailServiceProtocol {
        enum MockMode { case success, notFound, invalid }
        var mode: MockMode = .success

        func fetchPokemonsDetail(name: String) async throws -> PokemonDetail {
            switch mode {
            case .success:
                let pokemon: PokemonDetail = PokemonDetail.mock(id: 25)
                return pokemon
            case .notFound:
                // Error 404: Pokémon Not Found (Data Boundary)
                throw APIRequestError.apiError(code: 404, message: "Not Found")
            case .invalid:
                // Error 400: Invalid Input (Input Boundary)
                throw APIRequestError.badRequest(message: "Invalid name")
            }
        }
    }
    
    // MARK: - Tests
    
    // Partition 1: Valid Data (Happy Path)
    func test_loadDetail_success_shouldAssignPokemon() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .success
        let vm = PokemonDetailViewModel(pokeDetailService: mock)

        // When
        await vm.loadDetail(name: "pikachu")

        // Then
        XCTAssertNotNil(vm.pokemon)
        XCTAssertEqual(vm.pokemon?.name, "pikachu")
        XCTAssertFalse(vm.isLoading)
    }

    // Partition 3: The Wrong Franchise (Data Boundary)
    // Scenario: User searches for "Agumon" (Valid string, but 404 from API)
    func test_loadDetail_notFound_shouldNotCrash() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .notFound // Simulate 404
        let vm = PokemonDetailViewModel(pokeDetailService: mock)

        // When
        await vm.loadDetail(name: "agumon")

        // Then
        XCTAssertNil(vm.pokemon) // Should be nil
        XCTAssertFalse(vm.isLoading) // Should stop loading
        // In a real app, you might also assert that `vm.errorMessage` is set
    }
    
    // Partition 2: The Troll Input (Input Boundary)
    // Scenario: User taps search with empty text
    func test_loadDetail_emptyName_shouldHandleGracefully() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .invalid
        let vm = PokemonDetailViewModel(pokeDetailService: mock)

        // When: The Silent Killer (Empty Strings)
        await vm.loadDetail(name: "")

        // Then
        XCTAssertNil(vm.pokemon)
        XCTAssertFalse(vm.isLoading)
    }
}
