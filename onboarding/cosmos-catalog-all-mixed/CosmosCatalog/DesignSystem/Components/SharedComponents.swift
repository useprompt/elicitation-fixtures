import SwiftUI

struct PlanetCard: View {
    let planet: Planet

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(planet.gradient)
                    .frame(width: 68, height: 68)
                Circle()
                    .fill(.white.opacity(0.20))
                    .frame(width: 30, height: 30)
                    .offset(x: 12, y: -10)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(planet.name)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(CatalogTokens.textPrimary)
                Text(planet.blurb)
                    .font(.system(size: 13))
                    .foregroundStyle(CatalogTokens.textSecondary)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    MetaChip(text: planet.discoveryMethod.rawValue)
                    if let teq = planet.equilibriumTempK {
                        MetaChip(text: "\(Int(teq)) K")
                    }
                }
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(CatalogTokens.textSecondary.opacity(0.7))
        }
        .padding(14)
        .background(CatalogTokens.surface)
        .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous)
                .stroke(CatalogTokens.surfaceStroke, lineWidth: 1)
        )
    }
}

struct MetaChip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold, design: .rounded))
            .foregroundStyle(CatalogTokens.accent)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(CatalogTokens.accentSoft)
            .clipShape(Capsule())
    }
}

struct ParameterTile: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(CatalogTokens.textSecondary)
            Text(value)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(CatalogTokens.textPrimary)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(CatalogTokens.backgroundLift)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct LegacyPanel: View {
    let title: String
    let bodyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(AlternateTokens.highlight)
            Text(bodyText)
                .font(.system(size: 14))
                .foregroundStyle(AlternateTokens.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(AlternateTokens.fill)
        .overlay(
            RoundedRectangle(cornerRadius: AlternateTokens.radius)
                .stroke(AlternateTokens.highlight.opacity(0.5), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: AlternateTokens.radius))
    }
}
