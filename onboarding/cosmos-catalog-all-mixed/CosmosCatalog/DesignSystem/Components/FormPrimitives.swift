import SwiftUI

struct CatalogTextField: View {
    let title: String
    var placeholder: String = ""
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
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

struct CatalogPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundStyle(Color(red: 0.12, green: 0.09, blue: 0.05))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(CatalogTokens.accent.opacity(configuration.isPressed ? 0.75 : 1))
            .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
    }
}
