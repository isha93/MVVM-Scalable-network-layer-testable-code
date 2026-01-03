//
//  ErrorStateAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct ErrorStateAtom: View {
    let message: String
    var retryAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            
            Text(message)
                .font(AppFont.body())
                .foregroundColor(AppColor.textSecondary.color)
                .multilineTextAlignment(.center)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Try Again")
                        .font(AppFont.headline())
                        .foregroundColor(AppColor.textWhite.color)
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.vertical, AppSpacing.sm)
                        .background(AppColor.primary.color)
                        .cornerRadius(12)
                }
                .buttonStyle(.scalable)
            }
        }
        .padding(AppSpacing.xl)
    }
}
