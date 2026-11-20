import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    @State private var charted = false

    var body: some View {
        ZStack {
            CatalogTokens.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    hero
                    Text(planet.blurb)
                        .font(.system(size: 16))
                        .foregroundStyle(CatalogTokens.textSecondary)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ParameterTile(labelKey: "param_host", value: planet.hostname)
                        ParameterTile(labelKey: "param_discovery", value: planet.discoveryMethod.rawValue)
                        ParameterTile(labelKey: "param_period", value: format(planet.orbitalPeriodDays.map { "\($0) d" }))
                        ParameterTile(labelKey: "param_radius", value: format(planet.radiusEarth.map { String(format: "%.2f R⊕", $0) }))
                        ParameterTile(labelKey: "param_mass", value: format(planet.massEarth.map { String(format: "%.2f M⊕", $0) }))
                        ParameterTile(labelKey: "param_teq", value: format(planet.equilibriumTempK.map { "\(Int($0)) K" }))
                        ParameterTile(labelKey: "param_distance", value: format(planet.distancePc.map { String(format: "%.1f pc", $0) }))
                        ParameterTile(labelKey: "param_atmosphere", value: String(localized: "planet_detail_atmosphere"))
                    }

                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) { charted.toggle() }
                    } label: {
                        Text(charted ? "planet_detail_charted" : "home_cta_open_planet")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 0.12, green: 0.09, blue: 0.05))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(CatalogTokens.accent)
                            .clipShape(RoundedRectangle(cornerRadius: CatalogTokens.corner, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
                .padding(20)
            }
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(CatalogTokens.background, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(planet.gradient)
                .frame(height: 220)
            Circle()
                .fill(.white.opacity(0.16))
                .frame(width: 130, height: 130)
                .offset(x: 40, y: -36)
            VStack(alignment: .leading, spacing: 6) {
                Text(planet.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(planet.hostname)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding(18)
        }
    }

    private func format(_ value: String?) -> String {
        value ?? "—"
    }
}
