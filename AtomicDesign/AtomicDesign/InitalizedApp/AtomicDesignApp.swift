//
//  AtomicDesignApp.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/10/07.
//

import SwiftUI

@main
struct AtomicDesignApp: App {
        @State private var router = AppRouter()
        @State private var dependencies = AppDependencies()

        var body: some Scene {
            WindowGroup {
                NavigationStack(path: $router.path) {
                    let listVM = dependencies.makeListViewModel()
                    PokemonListView(viewModel: listVM)
                        .withAppRouter(dependencies: dependencies)
                }
                .environment(router)
            }
        }
}
