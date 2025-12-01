//
//  AppNavigationModifier.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//

import SwiftUI

struct AppNavigationModifier: ViewModifier {
    var dependencies: AppDependencies
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .list:
                    let vm = dependencies.makeListViewModel()
                    PokemonListView(viewModel: vm)
                    
                case .detail(let name):
                    let vm = dependencies.makeDetailViewModel()
                    PokemonDetailView(viewModel: vm, pokemonName: name)
                }
            }
    }
}

extension View {
    func withAppRouter(dependencies: AppDependencies) -> some View {
        self.modifier(AppNavigationModifier(dependencies: dependencies))
    }
}
