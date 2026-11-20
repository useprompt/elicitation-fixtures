import Foundation

struct ObservingTarget: Identifiable, Equatable {
    let id: UUID
    let planetName: String
    let observatory: String
    let note: String

    init(id: UUID = UUID(), planetName: String, observatory: String, note: String) {
        self.id = id
        self.planetName = planetName
        self.observatory = observatory
        self.note = note
    }
}
