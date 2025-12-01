//
//  PokemonListResponse.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
    var imageUrl: URL? {
        guard let urlObj = URL(string: url) else { return nil }
        
        // Validasi ekstra: pastikan ID-nya angka
        let idString = urlObj.lastPathComponent
        guard Int(idString) != nil else { return nil }
        
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idString).png")
    }
}

