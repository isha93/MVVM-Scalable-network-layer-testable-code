//
//  PokeListServiceTests.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/05.
//

import XCTest
@testable import AtomicDesign

final class PokeListServiceTests: XCTestCase {
    
    // Updated Mock to match the pattern in PokeDetailServiceTests
    class MockNetworker: NetworkerProtocol {
        enum Mode { case success, decodingFail, badRequest, serverError }
        var mode: Mode = .success

        func requestAsync<T>(type: T.Type, endPoint: Endpoint) async throws -> T where T : Decodable {
            switch mode {
            case .success:
                // Mock success response for the list
                return PokemonListResponse.mock(name: "bulbasaur") as! T
            case .decodingFail:
                throw APIRequestError.decodingError(message: "JSON Mismatch")
            case .badRequest:
                throw APIRequestError.badRequest(message: "Bad Request")
            case .serverError:
                throw APIRequestError.apiError(code: 500, message: "Server Error")
            }
        }
    }
    
    // MARK: - Success Path
    
    func test_fetchPokemons_success_shouldReturnList() async throws {
        // Given
        let mock = MockNetworker()
        mock.mode = .success
        let service = PokeListService(networker: mock)
        
        // When
        let response = try await service.fetchPokemons(limit: 20, offset: 0)
        
        // Then
        XCTAssertEqual(response.results.first?.name, "bulbasaur")
    }
    
    // MARK: - Boundary/Error Paths
    
    // Testing specific API error propagation (500 Server Error)
    func test_fetchPokemons_serverError_shouldPropagate() async {
        // Given
        let mock = MockNetworker()
        mock.mode = .serverError
        let service = PokeListService(networker: mock)
        
        // When/Then
        do {
            _ = try await service.fetchPokemons(limit: 20, offset: 0)
            XCTFail("Expected error not thrown")
        } catch let error as APIRequestError {
            if case .apiError(let code, _) = error {
                XCTAssertEqual(code, 500)
            } else {
                XCTFail("Wrong error type")
            }
        } catch {
            XCTFail("Generic error caught")
        }
    }
    
    // Testing Client Error (400 Bad Request)
    func test_fetchPokemons_badRequest_shouldThrowCorrectError() async {
        // Given
        let mock = MockNetworker()
        mock.mode = .badRequest
        let service = PokeListService(networker: mock)
        
        // When/Then
        do {
            _ = try await service.fetchPokemons(limit: -1, offset: -1) // Invalid inputs
            XCTFail("Expected error not thrown")
        } catch let error as APIRequestError {
            switch error {
            case .badRequest:
                XCTAssertTrue(true)
            default:
                XCTFail("Wrong error type")
            }
        } catch {
            XCTFail("Generic error caught")
        }
    }
}
