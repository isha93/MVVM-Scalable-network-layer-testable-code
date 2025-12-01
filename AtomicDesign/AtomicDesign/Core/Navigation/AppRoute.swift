//
//  AppRoute.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable {
    case list
    case detail(name: String)
}

@Observable
final class AppRouter {
    var path: [AppRoute] = []
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
