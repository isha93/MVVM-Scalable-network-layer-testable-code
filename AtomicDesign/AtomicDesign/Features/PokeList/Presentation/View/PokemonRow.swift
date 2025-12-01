//
//  PokemonRow.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: pokemon.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "pawprint.fill")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.headline)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.5))
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}
