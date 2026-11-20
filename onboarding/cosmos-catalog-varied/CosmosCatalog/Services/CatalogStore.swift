import Foundation
import Combine

@MainActor
final class CatalogStore: ObservableObject {
    @Published var planets: [Planet] = Planet.samples
    @Published var statusLine: String = String(localized: "status_archive_ready")
    @Published var selectedMethod: DiscoveryMethod?
    @Published var notes: [FieldNote] = FieldNote.seed
    @Published var targets: [ObservingTarget] = [
        ObservingTarget(planetName: "Kepler-22b", observatory: "Mauna Kea", note: "Transit window watch")
    ]

    private let catalog = RemotePlanetCatalog()
    private let stars = ConcreteStarService()

    var filteredPlanets: [Planet] {
        guard let selectedMethod else { return planets }
        return planets.filter { $0.discoveryMethod == selectedMethod }
    }

    func load() async {
        do {
            let remote = try await catalog.fetchPlanets()
            let featured = try await stars.fetchFeatured()
            planets = remote
            if let first = featured.first {
                statusLine = String(localized: "status_featured_prefix") + first
            }
        } catch {
            planets = Planet.samples
            statusLine = String(localized: "error_network")
        }
    }

    func queueTarget(planetName: String, observatory: String, note: String) {
        targets.insert(
            ObservingTarget(planetName: planetName, observatory: observatory, note: note),
            at: 0
        )
    }
}

extension FieldNote {
    static let seed: [FieldNote] = [
        FieldNote(
            id: "note-004",
            planetID: "kepler-22b",
            planetName: "Kepler-22b",
            body: "Ocean glitter along the terminator. Good candidate for a longer dwell.",
            stamped: "Two days ago"
        ),
        FieldNote(
            id: "note-011",
            planetID: "trappist-1e",
            planetName: "TRAPPIST-1e",
            body: "Twilight belt looks stable. Winds quieter than the last pass.",
            stamped: "Yesterday"
        ),
        FieldNote(
            id: "note-018",
            planetID: "proxima-b",
            planetName: "Proxima Cen b",
            body: "Flare shore still noisy. Hold off on surface probes for now.",
            stamped: "Today"
        )
    ]
}
