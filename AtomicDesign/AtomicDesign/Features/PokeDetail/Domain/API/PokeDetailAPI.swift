//
//  PokeDetailAPI.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


enum PokeDetailAPI {
    case getPokemonDetail(name: String)
}

extension PokeDetailAPI: Endpoint {
    var path: String {
        switch self {
        case.getPokemonDetail(let name):
            return "pokemon/\(name)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getPokemonDetail:
            return .requestPlain
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
