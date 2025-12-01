//
//  AppDependencies.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//

import SwiftUI

@Observable
class AppDependencies {
    func makeListViewModel() -> PokemonListViewModel {
        return PokemonListViewModel()
    }
    
    func makeDetailViewModel() -> PokemonDetailViewModel {
        return PokemonDetailViewModel()
    }
}
