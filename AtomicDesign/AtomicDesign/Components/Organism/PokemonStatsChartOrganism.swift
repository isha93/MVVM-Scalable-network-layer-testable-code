//
//  PokemonStatsChartOrganism.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct PokemonStatsChartOrganism: View {
    let stats: [PokemonStat]
    
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            SectionHeaderAtom(title: "Base Stats")
            
            VStack(spacing: AppSpacing.sm) {
                ForEach(stats) { stat in
                    StatRowMolecule(
                        statName: stat.stat.name,
                        value: stat.baseStat,
                        color: AppColor.stat(stat.stat.name)
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(AppColor.cardBackground.color)
        .cornerRadius(24)
    }
}
