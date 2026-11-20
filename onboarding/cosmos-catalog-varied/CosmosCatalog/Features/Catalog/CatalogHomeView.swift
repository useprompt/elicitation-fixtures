import SwiftUI

struct CatalogHomeView: View {
    @EnvironmentObject private var store: CatalogStore

    var body: some View {
        NavigationStack {
            ZStack {
                CatalogTokens.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        header
                        methodFilters
                        sectionLabel
                        planetList
                        Text(store.statusLine)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(CatalogTokens.textSecondary)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 28)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Planet.self) { planet in
                PlanetDetailView(planet: planet)
            }
            .task { await store.load() }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("home_title")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(CatalogTokens.textPrimary)
            Text("home_subtitle")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundStyle(CatalogTokens.textSecondary)
        }
    }

    private var methodFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(titleKey: "filter_all", selected: store.selectedMethod == nil) {
                    store.selectedMethod = nil
                }
                ForEach(DiscoveryMethod.allCases) { method in
                    FilterChip(
                        titleKey: method.filterKey,
                        selected: store.selectedMethod == method
                    ) {
                        store.selectedMethod = method
                    }
                }
            }
        }
    }

    private var sectionLabel: some View {
        Text("home_section_nearby")
            .font(.system(size: 13, weight: .semibold, design: .rounded))
            .foregroundStyle(CatalogTokens.textSecondary)
    }

    private var planetList: some View {
        LazyVStack(spacing: 12) {
            ForEach(store.filteredPlanets) { planet in
                NavigationLink(value: planet) {
                    PlanetCard(planet: planet)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct FilterChip: View {
    let titleKey: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(titleKey)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(selected ? Color(red: 0.12, green: 0.09, blue: 0.05) : CatalogTokens.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selected ? CatalogTokens.accent : CatalogTokens.surface)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(selected ? Color.clear : CatalogTokens.surfaceStroke, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

private extension DiscoveryMethod {
    var filterKey: String {
        switch self {
        case .transit: return "filter_transit"
        case .radialVelocity: return "filter_radial_velocity"
        case .imaging: return "filter_imaging"
        case .microlensing: return "filter_microlensing"
        }
    }
}
