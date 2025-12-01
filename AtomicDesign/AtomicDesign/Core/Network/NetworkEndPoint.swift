//
//  NetworkEndPoint.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/09/12.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation
import UIKit

// Defines the HTTP method
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum AuthorizationType {
    case anonymous
    case authorized
}

enum HTTPTask {
    case requestPlain
    case requestURLParameters(_ parameters: [String: Any])
    case requestJSONEncodable(_ body: Encodable)
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
    var authorizationType: AuthorizationType { get }
    var timeoutInterval: Double { get }
}

// MARK: - Default Implementations
extension Endpoint {
    var baseURL: String {
        // By default, return the base URL from Constants
        return Constants.baseURL
    }
    
    var headers: [String: String]? {
        // By default, return default headers
        HTTPHeaders.defaultHeaders()
    }
    
    var authorizationType: AuthorizationType {
        // By default, all endpoints require authorization
        return .anonymous
    }

    var timeoutInterval: Double {
        // By default, set timeout interval to 10 seconds
        return 10.0
    }
}
