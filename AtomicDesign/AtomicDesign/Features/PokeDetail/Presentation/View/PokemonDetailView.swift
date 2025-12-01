//
//  PokemonDetailView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

struct PokemonDetailView: View {
    @State var viewModel: PokemonDetailViewModel
    let pokemonName: String // Data ringan untuk judul sebelum loading selesai
    
    var body: some View {
        VStack(spacing: 24) {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let pokemon = viewModel.pokemon {
                // Tampilan Detail
                AsyncImage(url: URL(string: pokemon.species?.url ?? "")) { phase in
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
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                Text(pokemonName) // Pakai nama dari parameter dulu biar instan
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Text(pokemon.abilities?.first?.ability?.name ?? "")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundStyle(.blue)
                        .clipShape(Capsule())
                }
                
                Text("Description for \(pokemon.name) goes here...")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(pokemonName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail(name: pokemonName)
        }
    }
}
