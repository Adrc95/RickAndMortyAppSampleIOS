import Foundation

protocol LocationRepository {
    func getLocation(characterId: Int, locationId: Int, isOrigin: Bool) async throws -> LocationDetail?
}
