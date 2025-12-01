//
//  PokemonAPI.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

enum PokeListAPI {
    case getPokemonList(limit: Int, offset: Int)
}

extension PokeListAPI: Endpoint {
    var path: String {
        return "pokemon"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getPokemonList(let limit, let offset):
            return .requestURLParameters([
                "limit": limit,
                "offset": offset
            ])
        }
    }
    
    var authorizationType: AuthorizationType {
        return .anonymous
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var timeoutInterval: Double {
        return 30.0
    }
}
