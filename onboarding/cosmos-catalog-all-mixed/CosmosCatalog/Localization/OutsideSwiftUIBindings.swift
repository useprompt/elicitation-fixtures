import Foundation

enum OutsideSwiftUIBindings {
    static func catalogLoadFailed() -> String {
        String(localized: "validation.load.failed")
    }

    static func legacyNearbySection() -> String {
        NSLocalizedString(
            "HOME_SECTION_NEARBY",
            tableName: "LegacySidecar",
            bundle: .main,
            comment: "Legacy table copy"
        )
    }

    static func legacySplashTagline() -> String {
        NSLocalizedString(
            "SPLASH_TAGLINE",
            tableName: "LegacySidecar",
            bundle: .main,
            comment: "Legacy splash tagline"
        )
    }

    static func legacyNetworkError() -> String {
        NSLocalizedString(
            "ERROR_NETWORK",
            tableName: "LegacySidecar",
            bundle: .main,
            comment: "Legacy network error"
        )
    }
}
