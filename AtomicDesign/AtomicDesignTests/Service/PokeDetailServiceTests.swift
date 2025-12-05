//
//  PokeDetailServiceTests.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/05.
//

import XCTest
@testable import AtomicDesign

final class PokeDetailServiceTests: XCTestCase {
    class MockNetworker: NetworkerProtocol {
        enum Mode { case success, decodingFail, badRequest, serverError }
        var mode: Mode = .success

        func requestAsync<T>(type: T.Type, endPoint: Endpoint) async throws -> T where T : Decodable {
            switch mode {
            case .success:
                let pokemon: PokemonDetail = PokemonDetail.mock(name: "bulbasaur")
                // Hardcoded success for testing the happy path
                // Note: In a real app, you might make this generic, but for the tutorial, we hardcode to match the article.
                return pokemon as! T
            case .decodingFail:
                // Simulates a 200 OK but invalid JSON structure
                throw APIRequestError.decodingError(message: "JSON Mismatch")
            case .badRequest:
                // Simulates 400
                throw APIRequestError.badRequest(message: "Bad Request")
            case .serverError:
                // Simulates 500
                throw APIRequestError.apiError(code: 500, message: "Server Error")
            }
        }
    }

    // MARK: - Article Tests
    func test_fetchDetail_decodingError_shouldThrowCorrectError() async {
        let mock = MockNetworker()
        mock.mode = .decodingFail
        let service = PokeDetailService(networker: mock)

        do {
            _ = try await service.fetchPokemonsDetail(name: "pikachu")
            XCTFail("You shall not pass!")
        } catch let error as APIRequestError {
            switch error {
            case .decodingError:
                XCTAssertTrue(true) // We caught the imposter!
            default:
                XCTFail("Wrong error type: \(error)")
            }
        } catch {
            XCTFail("Generic error caught")
        }
    }
    
    func test_fetchDetail_serverError_shouldPropagate() async {
        let mock = MockNetworker()
        mock.mode = .serverError
        let service = PokeDetailService(networker: mock)

        do {
            _ = try await service.fetchPokemonsDetail(name: "mewtwo")
            XCTFail("Expected Server Error")
        } catch let error as APIRequestError {
            if case .apiError(let code, _) = error {
                XCTAssertEqual(code, 500) // Correctly identified the fire
            } else {
                XCTFail("Wrong error type")
            }
        } catch {
             XCTFail("Generic error")
        }
    }
    
    func test_fetchDetail_success_shouldReturnData() async throws {
        let mock = MockNetworker()
        mock.mode = .success
        let service = PokeDetailService(networker: mock)

        let result = try await service.fetchPokemonsDetail(name: "bulbasaur")

        XCTAssertEqual(result.name, "bulbasaur")
    }
}
