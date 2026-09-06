import Foundation
@testable import rickyandmorty

final class MockGetLocationByIdUseCase: GetLocationByIdUseCase {
    var returnedLocation: LocationDetail?
    var error: Error?
    private(set) var callCount = 0

    override func execute(characterId: Int, locationId: Int, isOrigin: Bool) async throws -> LocationDetail? {
        callCount += 1
        if let error { throw error }
        return returnedLocation
    }
}