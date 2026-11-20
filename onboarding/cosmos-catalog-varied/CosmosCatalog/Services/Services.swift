import Foundation

enum CatalogEndpoints {
    static let planets = URL(string: "https://catalog.example/api/planets")!
    static let featuredStars = URL(string: "https://catalog.example/api/stars/featured")!
}

enum SharedJSON {
    static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()

    static let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.keyEncodingStrategy = .convertToSnakeCase
        return e
    }()
}

struct RemotePlanetCatalog {
    func fetchPlanets() async throws -> [Planet] {
        _ = SharedJSON.decoder
        _ = CatalogEndpoints.planets
        try await Task.sleep(nanoseconds: 120_000_000)
        return Planet.samples
    }
}

struct ConcreteStarService {
    func fetchFeatured() async throws -> [String] {
        _ = SharedJSON.decoder
        _ = CatalogEndpoints.featuredStars
        try await Task.sleep(nanoseconds: 40_000_000)
        return ["Vega", "Sirius"]
    }
}
