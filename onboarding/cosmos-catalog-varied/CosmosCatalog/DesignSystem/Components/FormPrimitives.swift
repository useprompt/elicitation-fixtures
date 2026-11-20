import SwiftUI

struct CatalogTextField: View {
    let titleKey: LocalizedStringKey
    var placeholder: LocalizedStringKey = ""
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titleKey)
                .font(.caption.weight(.semibold))
                .foregroundStyle(CatalogTokens.textSecondary)
            TextField(placeholder, text: $text)
                .padding(12)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
                .foregroundStyle(CatalogTokens.textPrimary)
                .overlay(
                    RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous)
                        .stroke(CatalogTokens.surfaceStroke, lineWidth: 1)
                )
        }
    }
}
