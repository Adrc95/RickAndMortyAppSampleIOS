import Foundation
@testable import rickyandmorty

final class FakeLocationRepository: LocationRepository {

    private(set) var locations: [String: LocationDetail] = [:]
    var error: Error?

    func setLocation(_ location: LocationDetail, for id: Int, isOrigin: Bool) {
        locations[key(id: id, isOrigin: isOrigin)] = location
    }

    private func key(id: Int, isOrigin: Bool) -> String {
        "\(id)-\(isOrigin)"
    }

    func getLocation(characterId: Int, locationId: Int, isOrigin: Bool) async throws -> LocationDetail? {
        if let error { throw error }
        return locations[key(id: locationId, isOrigin: isOrigin)]
    }
}