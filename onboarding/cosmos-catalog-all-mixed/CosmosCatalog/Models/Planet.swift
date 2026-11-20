import SwiftUI

enum DiscoveryMethod: String, CaseIterable, Identifiable, Hashable {
    case transit = "Transit"
    case radialVelocity = "Radial Velocity"
    case imaging = "Imaging"
    case microlensing = "Microlensing"

    var id: String { rawValue }
}

struct Planet: Identifiable, Hashable {
    let id: String
    let name: String
    let hostname: String
    let discoveryMethod: DiscoveryMethod
    let orbitalPeriodDays: Double?
    let radiusEarth: Double?
    let massEarth: Double?
    let equilibriumTempK: Double?
    let distancePc: Double?
    let blurb: String
    let hue: Double

    var gradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(hue: hue, saturation: 0.42, brightness: 0.62),
                Color(hue: hue, saturation: 0.55, brightness: 0.22)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static let samples: [Planet] = [
        Planet(
            id: "kepler-22b",
            name: "Kepler-22b",
            hostname: "Kepler-22",
            discoveryMethod: .transit,
            orbitalPeriodDays: 289.9,
            radiusEarth: 2.38,
            massEarth: nil,
            equilibriumTempK: 262,
            distancePc: 180,
            blurb: "Temperate ocean-world candidate in the habitable zone.",
            hue: 0.55
        ),
        Planet(
            id: "hd-209458b",
            name: "HD 209458 b",
            hostname: "HD 209458",
            discoveryMethod: .transit,
            orbitalPeriodDays: 3.52,
            radiusEarth: 15.7,
            massEarth: 220,
            equilibriumTempK: 1450,
            distancePc: 48,
            blurb: "Hot Jupiter with an evaporating atmosphere.",
            hue: 0.08
        ),
        Planet(
            id: "trappist-1e",
            name: "TRAPPIST-1e",
            hostname: "TRAPPIST-1",
            discoveryMethod: .transit,
            orbitalPeriodDays: 6.10,
            radiusEarth: 0.91,
            massEarth: 0.69,
            equilibriumTempK: 251,
            distancePc: 12.4,
            blurb: "Rocky world in a compact seven-planet system.",
            hue: 0.72
        ),
        Planet(
            id: "proxima-b",
            name: "Proxima Cen b",
            hostname: "Proxima Centauri",
            discoveryMethod: .radialVelocity,
            orbitalPeriodDays: 11.2,
            radiusEarth: nil,
            massEarth: 1.27,
            equilibriumTempK: 234,
            distancePc: 1.3,
            blurb: "Nearest known exoplanet; red-dwarf flare environment.",
            hue: 0.02
        ),
        Planet(
            id: "beta-pic-b",
            name: "beta Pic b",
            hostname: "beta Pictoris",
            discoveryMethod: .imaging,
            orbitalPeriodDays: 8217,
            radiusEarth: 16.5,
            massEarth: 3500,
            equilibriumTempK: 1700,
            distancePc: 19.4,
            blurb: "Directly imaged gas giant in a young debris disk.",
            hue: 0.12
        ),
        Planet(
            id: "ogle-2005",
            name: "OGLE-2005-BLG-390L b",
            hostname: "OGLE-2005-BLG-390L",
            discoveryMethod: .microlensing,
            orbitalPeriodDays: nil,
            radiusEarth: nil,
            massEarth: 5.5,
            equilibriumTempK: 50,
            distancePc: 6500,
            blurb: "Cold, distant world found via gravitational microlensing.",
            hue: 0.62
        )
    ]
}
