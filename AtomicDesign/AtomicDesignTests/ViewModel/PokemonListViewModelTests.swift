//
//  PokemonListViewModelTests.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import XCTest
@testable import AtomicDesign

final class PokemonListViewModelTests: XCTestCase {

    // MARK: - Tests

    // Test: Load Data (Success)
    func test_loadData_validRequest_shouldSetPokemons() async {
        // Given
        let mock = MockPokeListService()
        mock.mode = .success
        mock.mockResponse = PokemonListResponse.mock(name: "pikachu", count: 1)
        let vm = PokemonListViewModel(pokeListService: mock)

        // When
        await vm.loadData()

        // Then
        XCTAssertEqual(vm.pokemons.count, 1)
        XCTAssertEqual(vm.pokemons.first?.name, "pikachu")
        XCTAssertFalse(vm.isLoading)
    }

    // Test: Load Data (Failure)
    func test_loadData_serviceThrows_shouldHandleErrorGracefully() async {
        // Given
        let mock = MockPokeListService()
        mock.mode = .failure(APIRequestError.badRequest(message: "Error"))
        let vm = PokemonListViewModel(pokeListService: mock)

        // When
        await vm.loadData()

        // Then
        XCTAssertEqual(vm.pokemons.count, 0)
        XCTAssertFalse(vm.isLoading)
    }

    // Test: Load Data (Already Loaded)
    func test_loadData_whenAlreadyLoaded_shouldNotCallService() async {
        // Given
        let mock = MockPokeListService()
        let vm = PokemonListViewModel(pokeListService: mock)
        vm.pokemons = [Pokemon(name: "bulbasaur", url: "1")]

        // When
        await vm.loadData()

        // Then
        XCTAssertEqual(mock.callCount, 0)
        XCTAssertEqual(vm.pokemons.count, 1)
    }

    // Test: Load Data (While Loading)
    func test_loadData_whileLoading_shouldIgnoreRequest() async {
        // Given
        let mock = MockPokeListService()
        let vm = PokemonListViewModel(pokeListService: mock)
        vm.isLoading = true

        // When
        await vm.loadData()

        // Then
        XCTAssertEqual(mock.callCount, 0)
        XCTAssertTrue(vm.isLoading)
    }

    // Test: Load More (Success)
    func test_loadMore_validRequest_shouldAppendPokemons() async {
        // Given
        let mock = MockPokeListService()
        mock.mode = .success
        // First load
        mock.mockResponse = PokemonListResponse.mock(name: "pikachu", count: 2, next: "next_url")
        let vm = PokemonListViewModel(pokeListService: mock)
        await vm.loadData()

        // Prepare for load more
        mock.mockResponse = PokemonListResponse.mock(name: "bulbasaur", count: 2, next: nil)

        // When
        await vm.loadMore()

        // Then
        XCTAssertEqual(vm.pokemons.last?.name, "bulbasaur")
        XCTAssertFalse(vm.isLoading)
    }

    // Test: Load More (Failure)
    func test_loadMore_serviceThrows_shouldKeepStateStable() async {
        // Given
        let mock = MockPokeListService()
        mock.mode = .failure(APIRequestError.badRequest(message: "Error"))
        let vm = PokemonListViewModel(pokeListService: mock)
        vm.pokemons = [Pokemon(name: "pikachu", url: "1")]

        // When
        await vm.loadMore()

        // Then
        XCTAssertEqual(mock.callCount, 1)
        XCTAssertEqual(vm.pokemons.count, 1)
        XCTAssertTrue(vm.hasMore)
        XCTAssertFalse(vm.isLoading)
    }

    // Test: Load More (Loading State)
    func test_loadMore_whileLoading_shouldIgnoreRequest() async {
        // Given
        let mock = MockPokeListService()
        let vm = PokemonListViewModel(pokeListService: mock)
        vm.isLoading = true // Simulate loading

        // When
        await vm.loadMore()

        // Then
        XCTAssertEqual(mock.callCount, 0)
        XCTAssertTrue(vm.isLoading)
    }

    // Test: Load More (No More Data)
    func test_loadMore_whenNoMore_shouldIgnoreRequest() async {
        // Given
        let mock = MockPokeListService()
        let vm = PokemonListViewModel(pokeListService: mock)
        vm.hasMore = false

        // When
        await vm.loadMore()

        // Then
        XCTAssertEqual(mock.callCount, 0)
        XCTAssertFalse(vm.isLoading)
    }
}
