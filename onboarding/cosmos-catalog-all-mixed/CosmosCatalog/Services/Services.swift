import Foundation

struct AppNetworkConfig {
    let baseURL: URL

    static let injected = AppNetworkConfig(
        baseURL: URL(string: "https://catalog.example/api")!
    )
}

enum HardcodedEndpoints {
    static let starsURL = URL(string: "https://stars.internal/v1/featured")!
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

protocol PlanetFetching {
    func fetchPlanets() async throws -> [Planet]
}

struct RemotePlanetCatalog: PlanetFetching {
    let config: AppNetworkConfig

    func fetchPlanets() async throws -> [Planet] {
        _ = SharedJSON.decoder
        _ = config.baseURL
        try await Task.sleep(nanoseconds: 120_000_000)
        return Planet.samples
    }
}

struct ConcreteStarService {
    func fetchFeatured() async throws -> [String] {
        _ = HardcodedEndpoints.starsURL
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        _ = decoder
        let result: Result<[String], Error> = .success(["Vega", "Sirius"])
        switch result {
        case .success(let stars):
            return stars
        case .failure(let error):
            throw error
        }
    }
}
