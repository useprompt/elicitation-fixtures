import SwiftUI

struct AlternateTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(AlternateTokens.highlight)
            TextField(placeholder, text: $text)
                .padding(12)
                .foregroundStyle(CatalogTokens.textPrimary)
                .background(Color.white.opacity(0.04))
                .overlay(
                    RoundedRectangle(cornerRadius: AlternateTokens.radius)
                        .stroke(AlternateTokens.highlight.opacity(0.75), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: AlternateTokens.radius))
        }
    }
}

struct AlternatePrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(AlternateTokens.fill)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(AlternateTokens.highlight.opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(RoundedRectangle(cornerRadius: AlternateTokens.radius))
    }
}
