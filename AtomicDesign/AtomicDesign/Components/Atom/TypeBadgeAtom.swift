//
//  TypeBadgeAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct TypeBadgeAtom: View {
    let type: String
    
    var body: some View {
        Text(type.capitalized)
            .font(AppFont.subheadline())
            .foregroundColor(AppColor.textWhite.color)
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.xs)
            .background(AppColor.pokemonType(type))
            .clipShape(Capsule())
    }
}
